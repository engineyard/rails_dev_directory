class Answer < ActiveRecord::Base
  
  belongs_to :question
  
  named_scope :correct, :conditions => { :correct => true }

end
