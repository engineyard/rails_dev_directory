class Sitting < ActiveRecord::Base
  
  has_many :responses
  belongs_to :quiz
  belongs_to :provider
  
  attr_protected :quiz_id, :provider_id
  
  accepts_nested_attributes_for :responses
  
  def score
    responses.correct.count
  end
  
  def expired?
    ((Time.now - created_at) / 60) > quiz.time_limit.to_i
  end
end
