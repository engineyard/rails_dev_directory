class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :answer
  belongs_to :provider
end
