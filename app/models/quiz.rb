class Quiz < ActiveRecord::Base

  validates_presence_of :name
  
  has_many :questions, :order => 'id asc'
  has_many :results, :class_name => 'QuizResult'
  
  def self.options_for_select
    all(:order => :name).collect { |quiz| [quiz.name, quiz.id] }
  end

end
