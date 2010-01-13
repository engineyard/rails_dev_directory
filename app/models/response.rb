class Response < ActiveRecord::Base
  
  validates_uniqueness_of :question_id, :scope => :sitting_id
  validates_presence_of :answer_id
  
  belongs_to :question
  belongs_to :answer
  belongs_to :provider
  
  named_scope :correct, :joins => :question, :conditions => "answer_id = questions.correct_answer_id"
end
