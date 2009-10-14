class Request < ActiveRecord::Base
  belongs_to :provider
  belongs_to :rfp

  after_create :send_rfp_notification
  
  audit
  
  named_scope :recent, :order => "created_at DESC", :limit => 5
  
  def can_view?(user)
    provider.users.include?(user)
  end

private
  
  def send_rfp_notification
    Notification.deliver_rfp_notification(self) if provider and provider.user
  end
end
