class Quiz < ActiveRecord::Base

  validates_presence_of :name
  
  has_many :questions
  
  def self.options_for_select
    all(:order => :name).collect { |sc| [sc.name, sc.id] }
  end

end
