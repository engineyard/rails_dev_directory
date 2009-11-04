class QuizResult < ActiveRecord::Base

  belongs_to :provider
  belongs_to :quiz
  has_many :answers, :class_name => 'QuizResultAnswer'
  has_many :unanswered, :class_name => 'QuizResultAnswer',
           :conditions => 'answer_id IS NULL'
  has_many :correct_answers, :class_name => 'QuizResultAnswer',
           :conditions => { :correct => true }
  has_many :incorrect_answers, :class_name => 'QuizResultAnswer',
           :conditions => { :correct => false }
  has_many :questions,
           :through => :answers
  
  before_create :create_answers
  
  named_scope :passed, :conditions => { :passed => true }
  
  def completed?
    passed.not.nil?
  end
  
  def mark!
    passed = answers.not.any? { |answer| answer.not.correct? }
    self.update_attribute(:passed, passed)
    provider.activate! if passed and provider.not.active?
  end
  
  def score
    [correct_answers.count, answers.count]
  end
  
  private
  
  def create_answers
    quiz.questions.each do |question|
      answers.build(:question_id => question.id)
    end
  end

end
