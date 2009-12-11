class CodeSample < ActiveRecord::Base
  include AASM
  
  validates_presence_of :name, :code
  
  belongs_to :provider
  
  attr_protected :score, :provider_id

  aasm_initial_state :review

  aasm_state :review
  aasm_state :show
  
  aasm_event :analyze do
    transitions :to => :show, :from => [:review]
  end
  
  def reek
    run_test('reek').size - 1
  end
  
  def flay
    run_test('flay').first.split.reverse.first.to_i
  end
  
  def flog
    run_test('flog').first.to_f
  end
  
  def roodi
    run_test('roodi').last.split[1].to_i
  end
  
  def saikuro
    with_tmp_file do |file|
      tmp_dir = "/tmp/d_#{code.to_sha1}"
      system("saikuro -f text -c -p #{file} -o #{tmp_dir}")
      output = File.read("#{tmp_dir}#{file}_cyclo.html")
      result = output.scan(/Complexity:(\d*)/).flatten.map{|i| i.to_i}.mean
      FileUtils.rm_f(tmp_dir)
      result
    end
  end
  
  def run_test(test)
    with_tmp_file { |file| `#{test} #{file}` }.split("\n")
  end
  
  def with_tmp_file(&block)
    tmp_file = "/tmp/f_#{code.to_sha1}"
    File.open(tmp_file, 'w') do |file|
      file.write(code)
    end
    out = yield(tmp_file)
    File.unlink(tmp_file)
    out
  end
  
end