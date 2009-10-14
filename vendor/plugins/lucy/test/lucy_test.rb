require 'test_helper'

class LucyTest < Test::Unit::TestCase

  KEY = 'test'
  PATH = File.join(File.dirname(__FILE__), 'test.js')
  CONTENT = {:foo => "bar", :bar => {:ponies => true}, :numbers => [1,2,3]}

  def test_generate_should_generate_file
    Lucy.generate(KEY, CONTENT, PATH)
    assert File.exists?(PATH)
  end

  def test_generate_should_yield_generator
    generator = nil
    Lucy.generate(KEY,CONTENT,PATH){|g| generator = g }
    assert_not_nil generator
    assert generator.is_a?(Lucy::JavascriptGenerator)
  end

  def test_generate_should_write_file_after_block_returns
    content = nil
    Lucy.generate KEY, nil, PATH do |g|
      g.init_namespace = false
      g.namespace = "Test"
      g[:foo] = "humbaba"
      content = g.to_js
    end
    assert_equal content, File.read(PATH)
  end

  def teardown
    File.unlink(PATH) if File.exists?(PATH)
  end

end


class JavascriptGeneratorTest < Test::Unit::TestCase

  GLOBAL = 'test'
  NAMESPACE = 'Test'
  NAMESPACE_INIT = "if (!#{GLOBAL}.#{NAMESPACE}) { #{NAMESPACE} = {}; }"
  NAMED = {:foo => "bar", :bar => {:ponies => true}, :numbers => [1,2,3]}
  NAMED_EXPECTED = NAMED.map{|k,v| "#{NAMESPACE}.#{k} = #{ActiveSupport::JSON.encode(v)};" }
  RAW = "function humbaba(){ alert('Whatcha doin in my forest?'); };"
  EXPECTED_OUTPUT = ([NAMESPACE_INIT]+NAMED_EXPECTED+[RAW]).join("\n\n")

  def setup
    @generator = Lucy::JavascriptGenerator.new
    @generator.global = GLOBAL
    @generator.namespace = NAMESPACE
    NAMED.each{|k,v| @generator[k] = v }
    @generator << RAW
  end

  def test_should_include_init_namespace_by_default
    assert_equal NAMESPACE_INIT, @generator.to_a.first
  end

  def test_should_not_include_init_namespace_when_told_not_to
    @generator.init_namespace = false
    assert_not_equal NAMESPACE_INIT, @generator.to_a.first
  end

  def test_should_generate_properties_added_by_write
    assert_equal NAMED_EXPECTED, @generator.to_a[1,3]
  end

  def test_should_add_raw
    assert_equal RAW, @generator.to_a.last
  end

  def test_should_concatenate_named_and_raw_with_to_js
    assert_equal EXPECTED_OUTPUT, @generator.to_js
  end

end
