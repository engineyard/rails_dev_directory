require 'digest/sha1'

class User < ActiveRecord::Base  
  belongs_to :provider

  after_create :reset_token
  after_create :send_welcome

  acts_as_authentic
  can_has?
  
  attr_protected :admin, :provider_id, :password, :password_confirmation
  
  def full_name
    "#{first_name} #{last_name}".strip
  end
  alias_method :name, :full_name
  
  def first_name_or_email
    begin
      return TMail::Address.parse(email).local if first_name.blank?
      first_name
    rescue TMail::SyntaxError
      email
    end
  end
  
  def can_edit?(user)
    if user.kind_of?(User)
      user.provider.user == self || user == self
    else
      super(user)
    end
  end
  
  def can_view?(user)
    if user.kind_of?(User)
      user.provider == provider
    else
      super(user)
    end
  end
  
  def welcome_message(subject = nil, message = nil)
    if provider && provider.user == self
      Notification.create_provider_welcome(self, subject, message)
    else
      Notification.create_user_welcome(self, subject, message)
    end    
  end

  def send_welcome(subject = nil, message = nil)
    Notification.deliver(welcome_message(subject, message)) if send_welcome_message?
  end
  
  def send_welcome_message?
    return true if @send_welcome_message.nil?
    return @send_welcome_message if @send_welcome_message.is_a?(TrueClass) or @send_welcome_message.is_a?(FalseClass)
    @send_welcome_message.to_i > 0 ? true : false
  end
  alias_method :send_welcome_message, :send_welcome_message?
  
  def send_welcome_message=(boolean)
    @send_welcome_message = boolean
  end
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!
    Notification.deliver_password_reset_instructions(self)  
  end
  
  def reset_token
    reset_perishable_token!
  end
end
