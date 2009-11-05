class Feedback < ActiveRecord::Base
  include AASM
  
  validates_presence_of :name, :year_hired, :position, :company, :email, :message, :project
  validates_presence_of :provider_id
  validate_on_create :hired_after_provider_joined
  
  aasm_initial_state :new
  
  aasm_state :new
  aasm_state :accepted
  aasm_state :rejected
  aasm_event :accept do
    transitions :to => :accepted, :from => [:new]
  end
  aasm_event :reject do
    transitions :to => :rejected, :from => [:new]
  end
  
  attr_protected :provider_id, :aasm_state
  
  audit
  format_dates :timestamps
  
  belongs_to :provider
  
  after_create :deliver_notification
  
  named_scope :accepted, :conditions => { :aasm_state => 'accepted' }
  named_scope :unaccepted, :conditions => { :aasm_state => 'new' }
  
  def state
    aasm_state
  end
  
  private
  
  def deliver_notification
    Notification.deliver_feedback_notification(self)
  end

  def hired_after_provider_joined
    if year_hired.to_i < provider.created_at.year
      errors.add(:year_hired, t('feedback.validations.prior_to_joining', :company => provider))
    end
  end

end
