class Recommendation < ActiveRecord::Base
  include AASM
  
  validates_presence_of :name, :year_hired, :position, :company, :email, :url, :endorsement
  
  aasm_initial_state :new
  
  aasm_state :new
  aasm_state :approved
  aasm_state :rejected
  aasm_event :approve do
    transitions :to => :approved, :from => [:new, :rejected, :approved]
  end
  aasm_event :reject do
    transitions :to => :rejected, :from => [:new, :rejected, :approved]
  end
  
  attr_protected :provider_id, :aasm_state
  
  audit
  url_field :url
  format_dates :timestamps
  
  belongs_to :provider
  
  after_save :activate_provider
  after_save :update_provider_counter_cache
  after_create :deliver_notification
  after_destroy :update_provider_counter_cache
  
  named_scope :recent, :order => "created_at desc", :limit => 3
  named_scope :approved, :conditions => {:aasm_state => 'approved'}

  def activate_provider
    provider.check_recommendations_and_activate if provider and provider.status == 'inactive'
  end
  
  def update_provider_counter_cache
    self.provider.update_attribute(:recommendations_count, provider.recommendations.approved.count) if provider
  end
  
  def state
    aasm_state
  end
  
private
  def deliver_notification
    Notification.deliver_endorsement_notification(self) if provider and provider.email
  end
end