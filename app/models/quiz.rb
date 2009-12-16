class Quiz < ActiveRecord::Base

  validates_presence_of :name
  
  has_many :questions, :order => 'id asc'
  has_many :results, :class_name => 'QuizResult'
  
  accepts_nested_attributes_for :questions, :reject_if => proc { |attr| attr['text'].blank? }
  
  def self.options_for_select
    all(:order => :name).collect { |quiz| [quiz.name, quiz.id] }
  end
  
  def results_for(provider)
    returning 0 do |correct_results|
      questions.each do |question|
        response = provider.responses.first(:conditions => {:question_id => question.id})
        correct_results = correct_results + 1 if question.correct_answer == response.answer
      end
    end
  end

end
