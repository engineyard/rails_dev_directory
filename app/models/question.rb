class Question < ActiveRecord::Base

  ANSWERS = 4
  
  validates_presence_of :text
  validate :ensure_at_least_one_correct_answer
  
  belongs_to :quiz
  has_many :answers
  
  accepts_nested_attributes_for :answers, :reject_if => proc { |attr| attr['text'].blank? }
  
  private
  
  def ensure_at_least_one_correct_answer
    errors.add(:answers, I18n.t('question.no_correct_answer')) if
      answers.select { |a| a.correct? }.empty?
  end

end
