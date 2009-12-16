class Response < ActiveRecord::Base
  
  validates_uniqueness_of :question_id, :scope => :provider_id
  
  belongs_to :question
  belongs_to :answer
  belongs_to :provider
end
