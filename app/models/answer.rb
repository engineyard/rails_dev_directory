class Answer < ActiveRecord::Base

  validates_presence_of :text
  
  belongs_to :question
  
  named_scope :correct, :conditions => { :correct => true }

end
