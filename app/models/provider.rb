require 'exportable'
require 'carrierwave/orm/activerecord'
class Provider < ActiveRecord::Base
  include AASM
  
  validates_presence_of :city, :slug
  validates_uniqueness_of :slug
  validates_acceptance_of :terms_of_service
  validates_length_of :marketing_description, :maximum => 300, :allow_nil => true
  validate :name_is_not_a_reserved_country_name
  validates_numericality_of :min_budget, :min_hours, :max_hours, :allow_nil => true
  
  audit
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "64x64>" }
  mount_uploader :avatar, AvatarUploader
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
  
  define_completeness_scoring do
    check :name, lambda { |provider| provider.company_name.not.blank? or (provider.user and provider.user.name.not.blank?) }, 10
    check :hourly_rate, lambda { |provider| provider.hourly_rate.to_i.not.zero? }, 5
    check :project_length, lambda { |provider| provider.min_project_length.not.blank? and provider.max_project_length.not.blank? }, 5
    check :hours, lambda { |provider| provider.min_hours.not.blank? and provider.max_hours.not.blank? }, 5
    check :one_quiz_taken, lambda { |provider| provider.quiz_results.any? }, 5
    
    check :languages, lambda { |provider| provider.languages.not.empty? }, 5
    check :photo, lambda { |provider| provider.avatar.not.blank? }, 5
    check :payment_method, lambda { |provider| provider.accepted_payment_methods }, 5
    
    check :code_sample, lambda { |provider| provider.code_samples.any? }, 10
    check :many_quizzes, lambda { |provider| provider.quiz_results.many? }, 10
    
    check :services, lambda { |provider| provider.services.priority(2).any? }, 5
  end
  
  attr_protected :aasm_state, :slug, :user_id, :endorsements_count
  
  has_many :bookings, :order => "date asc"
  has_many :future_bookings, :order => "date asc", :conditions => ["date >= ?", Date.today], :class_name => "Booking"
  has_many :code_samples
  has_many :endorsement_requests
  has_many :endorsements, :order => "sort_order asc"
  has_many :feedbacks
  has_many :portfolio_items, :order => "year_completed desc"
  has_many :quiz_results, :order => 'created_at desc'
  has_many :requests, :dependent => :destroy, :order => 'created_at desc'
  has_many :responses
  has_many :rfps, :through => :requests
  has_many :sittings
  has_many :uncompleted_quizzes, :class_name => 'Quiz',
             :finder_sql => 'NOT EXISTS (SELECT * FROM quiz_results WHERE quiz_results.quiz_id = quizzes.id AND quiz_results.provider_id = #{self.id} AND quiz_results.passed = 1)'
  has_many :users, :dependent => :destroy

  
  has_many :provided_services, :dependent => :destroy do
    def for_service(service)
      first(:conditions => { :service_id => service.id })
    end
  end
  has_many :services, :through => :provided_services, :order => 'position asc'

  belongs_to :user
  
  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :provided_services,
                                :allow_destroy => true
  accepts_nested_attributes_for :bookings, :allow_destroy => true
  accepts_nested_attributes_for :future_bookings, :allow_destroy => true

  before_validation_on_create :save_slug
  before_validation :filter_carraige_returns
  before_create :set_first_user_provider
  before_save :activate_if_criteria_passed
  after_create :set_first_user_as_owner
  after_create :set_default_services
  
  named_scope :active, :conditions => {:aasm_state => 'active'}
  named_scope :inactive, :conditions => {:aasm_state => 'inactive'}
  named_scope :flagged, :conditions => {:aasm_state => 'flagged'}
  named_scope :all_by_company_name, :order => :company_name
  named_scope :by_country, :group => :country, :order => :country, :select => :country, :conditions => "country != ''"
  named_scope :by_state, :conditions => "state_province != 'NA' and state_province != ''", :group => :state_province, :order => :state_province, :select => :state_province
  named_scope :us_based, :conditions => {:country => 'US'}
  named_scope :all_by_location, :order => Country.order_sql + ", state_province", :conditions => "country != ''"
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
    conditions = ["aasm_state = 'active'"]
    joins = nil
    group = nil

    if params[:budget].not.blank?
      conditions[0] << " and min_budget <= ?"
      conditions << params[:budget].gsub(/[^0-9\.]/, '').to_i
    end

    if params[:hourly_rate].not.blank?
      params[:hourly_rate] = Behavior.config[:cheap_hourly_rate] if params[:hourly_rate] == '$'
      params[:hourly_rate] = Behavior.config[:medium_hourly_rate] if params[:hourly_rate] == '$$'
      params[:hourly_rate] = Behavior.config[:high_hourly_rate] if params[:hourly_rate] == '$$$'
      min,max = params[:hourly_rate].split('-')
      if min and min.not.empty?
        conditions[0] << " and hourly_rate >= ?"
        conditions << min.to_i
      end
      if max and max.not.empty?
        conditions[0] << " and hourly_rate <= ?"
        conditions << max.to_i
      end
    end
    
    if params[:hours].not.blank?
      min,max = params[:hours].split('-')
      if min and min.not.empty?
        conditions[0] << " and min_hours <= ?"
        conditions << min.to_i
      end
      if max and max.not.empty?
        conditions[0] << " and max_hours >= ?"
        conditions << max.to_i
      end
    end
    
    if params[:weeks].not.blank?
      min,max = params[:weeks].split('-')
      if min and min.not.empty?
        conditions[0] << " and min_project_length >= ?"
        conditions << (min.to_i * 30)
      end
      if max and max.not.empty?
        conditions[0] << " and max_project_length <= ?"
        conditions << (max.to_i * 30)
      end
    end
    
    if params[:availability].not.blank?
      month = Date.parse(params[:availability])
      conditions[0] << " and (select count(*) from bookings where provider_id = providers.id and DATE_FORMAT(date, '%m') = ?) != ?"
      conditions << month.strftime("%m").to_i
      conditions << month.end_of_month.day
    end

    if params[:service_ids].not.blank? and params[:service_ids].is_a?(Array)
      params[:service_ids] = params[:service_ids].uniq
      conditions[0] << " and (select count(*) from provided_services where provider_id = providers.id and service_id IN (?)) = #{params[:service_ids].reject { |s| s.blank? }.size}"
      conditions << params[:service_ids].reject { |s| s.blank? }.collect { |s| s.to_i }
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

    paginate(:joins => joins, :group => group, :conditions => conditions, :order => "aasm_state asc, if(endorsements_count >= 3,endorsements_count,0) desc, RAND()", :limit => 10, :page => params[:page])
  end
  
  def self.locations_for_select
    out = []
    by_country.each do |provider|
      out << [I18n.t("countries.#{provider.country}"), provider.country]
    end
    out
  end
  
  def self.options_for_select
    all(:order => 'company_name').collect{ |p| [p.company_name, p.id]}
  end
  
  def first_name
    return user.first_name if user and user.first_name.not.blank?
    company_name
  end
  
  def name
    return user.name if user and user.name.not.blank?
    company_name
  end

  def to_param
    slug
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
    return nil if hourly_rate.nil? or hourly_rate == 0
    "%.2f" % hourly_rate
  end
  
  def min_budget_formatted
    return nil if min_budget.nil?
    "%.2f" % min_budget
  end

  def activate_if_criteria_passed
    return unless quiz_results.passed.any?
    return unless hourly_rate.not.blank?
    return unless availability_set?
    activate! if aasm_state == 'inactive'
  end
  
  def availability_set?
    min_hours.not.blank? and max_hours.not.blank?
  end

  def has_enough_portfolio_items?
    portfolio_items.size >= 3
  end
  
  def booked_for(month)
    days_in_month = month.end_of_month.day
    bookings.count(:conditions => ["DATE_FORMAT(date, '%m') = ?", month.strftime("%m")]) == days_in_month.to_i
  end
  
  def soonest_availability
    [Date.today, 1.month.from_now, 2.months.from_now].each do |month|
      return month if !booked_for(month)
    end
    return nil
  end
  
  def languages
    category = ServiceCategory.find_by_name(Behavior.config[:language_service])
    return [] unless category
    services.find_all_by_service_category_id(category.id)
  end

  def accepted_payment_methods
    category = ServiceCategory.find_by_name(Behavior.config[:payment_service])
    return [] unless category
    services.find_all_by_service_category_id(category.id)
  end
  
  def can_edit?(user)
    users.include?(user)
  end
  
private
  def save_slug
    self.slug = slugged_company_name
    if slug.blank?
      self.slug = user.slugged_name if user
    end
    if slug.blank?
      self.slug = 'unnamed'
    end
    n = 1
    while Provider.find_by_slug(slug)
      self.slug = "#{slug}-#{n}"
      n = n.next
    end
  end
  
  def set_first_user_as_owner
    update_attribute(:user, users.first) if users.first
  end
  
  def set_first_user_provider
    users.first.provider = self if users.first
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