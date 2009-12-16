class Question < ActiveRecord::Base

  ANSWERS = 4
  
  validates_presence_of :text
  
  belongs_to :quiz
  belongs_to :correct_answer, :class_name => "Answer"
  has_many :answers
  
  accepts_nested_attributes_for :answers, :reject_if => proc { |attr| attr['text'].blank? }

end