class Reference < ActiveRecord::Base

  validates_presence_of :message
  
  # Unfortunately 'request' is a reserved word
  belongs_to :reference_request
  
  after_create :send_reference
  
  private
  
  def send_reference
    Notification.deliver_reference(self)
  end

end
