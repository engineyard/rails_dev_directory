require 'exportable'
class Provider < ActiveRecord::Base
  include AASM
  
  validates_presence_of :company_name, :city, :email, :company_url
  validates_uniqueness_of :slug
  validate_on_create :first_user_has_email_matching_company_url
  validates_acceptance_of :terms_of_service
  validates_length_of :marketing_description, :maximum => 300, :allow_nil => true
  validate :name_is_not_a_reserved_country_name
  
  audit
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "64x64>" }
  xss_terminate :sanitize => [:marketing_description]
  format_dates :timestamps
  
  aasm_initial_state :inactive

  aasm_state :active
  aasm_state :flagged
  aasm_state :inactive
  aasm_event :activate do
    transitions :to => :active, :from => [:inactive]
  end
  
  url_field :company_url
  
  attr_protected :aasm_state, :slug, :user_id, :recommendations_count
  
  has_many :users, :dependent => :destroy
  has_many :requests, :dependent => :destroy, :order => 'created_at desc'
  has_many :rfps, :through => :requests
  has_many :recommendations, :order => "sort_order asc"
  has_many :endorsement_requests
  has_many :portfolio_items, :order => "year_completed desc"
  
  has_many :provided_services, :dependent => :destroy
  has_many :services, :through => :provided_services
  
  belongs_to :user
  
  accepts_nested_attributes_for :users
  
  before_validation_on_create :save_slug
  before_validation :filter_carraige_returns
  before_create :set_first_user_provider
  after_create :set_first_user_as_owner
  after_create :send_owner_welcome
  after_create :set_default_services
  
  named_scope :active, :conditions => {:aasm_state => 'active'}, :order => :company_name
  named_scope :inactive, :conditions => {:aasm_state => 'inactive'}, :order => :company_name
  named_scope :flagged, :conditions => {:aasm_state => 'flagged'}, :order => :company_name
  named_scope :all_by_company_name, :order => :company_name
  named_scope :by_country, :group => :country, :order => :country, :select => :country, :conditions => "country != ''"
  named_scope :by_state, :conditions => "state_province != 'NA' and state_province != ''", :group => :state_province, :order => :state_province, :select => :state_province
  named_scope :us_based, :conditions => {:country => 'US'}
  named_scope :all_by_location, :order => "country, state_province", :conditions => "country != ''"
  named_scope :from_country, lambda { |country| {:conditions => {:country => country.to_s}}}
  named_scope :from_state, lambda { |state| {:conditions => {:state_province => state.to_s}}}
  
  def self.find(*args)
    if args.not.many? and args.first.kind_of?(String) and args.first.not.match(/^\d*$/)
      find_by_slug(args)
    else
      super(*args)
    end
  end
  
  def self.search(params)
    conditions = ["aasm_state != 'flagged'"]
    if params[:budget].not.blank?
      conditions[0] << " and min_budget <= ?"
      conditions << params[:budget].gsub(/[^0-9\.]/, '').to_i
    end

    joins = nil
    group = nil

    if params[:service_ids].not.blank? and params[:service_ids].is_a?(Array)
      joins = :provided_services
      conditions[0] << " and provided_services.service_id IN (?)"
      conditions << params[:service_ids].collect { |t| t.to_i }
      group = "provider_id"
    end
    
    if params[:location].not.blank?
      if params[:location][0,3] == 'US-'
        conditions[0] << " and state_province = ?"
        conditions << params[:location].gsub('US-', '')
      else
        conditions[0] << " and country = ?"
        conditions << params[:location]
      end
    end
    
    if params[:countries].not.blank? and params[:countries].is_a?(Array)
      conditions[0] << " and country IN (?)"
      conditions << params[:countries]
    end
    
    if params[:states].not.blank? and params[:states].is_a?(Array)
      if params[:countries].not.blank? and params[:countries].is_a?(Array)
        conditions[0] << " and if(country = 'US', state_province IN (?), ?)"
        conditions << params[:states]
        conditions << true
      else
        conditions[0] << " and state_province IN (?)"
        conditions << params[:states]
      end
    end

    all(:joins => joins, :group => group, :conditions => conditions, :order => "aasm_state asc, if(recommendations_count >= 3,recommendations_count,0) desc, RAND()", :limit => 10)
  end
  
  def self.locations_for_select
    out = []
    by_country.each do |provider|
      out << [I18n.t("countries.#{provider.country}"), provider.country]
    end
    out
  end

  def to_param
    slug
  end
  
  def self.options_for_company_size
    [["2-10", 2], ["11-30", 11], ["31-100", 31], ["100+", 100]]
  end
  
  def self.states
    aasm_states.collect { |s| s.name.to_s }
  end
  
  def active?
    aasm_state == 'active'
  end
  
  def address
    [
      street_address,
      city,
      State.by_code(state_province),
      postal_code,
      country.blank? ? nil : I18n.t('countries')[country.to_sym]
        ].reject { |part| part.blank?}
  end
  
  def private_address
    [ 
      city,
      State.by_code(state_province),
      country.blank? ? nil : I18n.t('countries')[country.to_sym]
        ].reject { |part| part.blank?}
  end
  
  def status
    aasm_state
  end
  
  def slugged_company_name
    company_name.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s/,'-') if company_name
  end
  
  def users_for_select
    users.collect { |u| [u.name, u.id] }
  end
  
  def hourly_rate_formatted
    return nil if hourly_rate.nil?
    "%.2f" % hourly_rate
  end
  
  def min_budget_formatted
    return nil if min_budget.nil?
    "%.2f" % min_budget
  end

  def check_recommendations_and_activate
    activate! if recommendations.approved.size >= 3
  end

  def has_enough_portfolio_items?
    portfolio_items.size >= 3
  end
  
  def can_edit?(user)
    users.include?(user)
  end
  
private
  def save_slug
    self.slug = slugged_company_name
  end
  
  def first_user_has_email_matching_company_url
    return true unless users.first and company_url.not.blank? and users.first.email.not.blank?
    company_url_host = URI.parse(cleaned_company_url).host
    user_email_host = TMail::Address.parse(users.first.email).domain
    if !company_url_host.match(/#{user_email_host}$/)
      errors.add_to_base(I18n.t('provider.validations.user_email_cannot_be_different_domain'))
    end
  rescue
    errors.add_to_base(I18n.t('provider.validations.valid_url'))
  end
  
  def set_first_user_as_owner
    update_attribute(:user, users.first) if users.first
  end
  
  def set_first_user_provider
    users.first.provider = self if users.first
  end
  
  def send_owner_welcome
    Notification.deliver_provider_welcome(user) if user
  end
  
  def owner_name
    user.name if user
  end
  
  def owner_email
    user.email if user
  end
  
  def set_default_services
    Service.checked.each do |service|
      services << service
    end
  end
  
  def filter_carraige_returns
    return if marketing_description.blank?
    self.marketing_description = marketing_description.gsub("\r\n", "\n")
  end
  
  def name_is_not_a_reserved_country_name
    if Country.slugs.include?(slugged_company_name) or State.slugs.include?(slugged_company_name)
      errors.add(:company_name, I18n.t('provider.validations.reserved_name'))
    end
  end
end