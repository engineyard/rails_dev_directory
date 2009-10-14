require 'exportable'
class Rfp < ActiveRecord::Base

  validates_presence_of :project_name, :first_name, :last_name, :email
  validate :budget_fits
  validates_acceptance_of :terms_of_service
  
  has_many :requests, :dependent => :destroy
  has_many :providers, :through => :requests
  has_many :requested_services

  after_save :add_checked_requested_services
  
  audit
  format_dates [:timestamps, :start_date, :due_date]
  
  accepts_nested_attributes_for :requested_services, :allow_destroy => true, :reject_if => proc { |attrs| attrs['add'] != "1" }
  
  shortcode_url :length => 20

  def self.options_for_budget
    [["$5k-$20k", 5000], ["$20k - $100k", 20000], ["$100k+", 100000]]
  end
  
  def self.find(*args)
    if args.not.many? and args.first.kind_of?(String)
      find_by_shortcode_url(args)
    else
      super(*args)
    end
  end
  
  def to_param
    shortcode_url
  end
  
  def budget=(price)
    price = BigDecimal.new(price.to_s)
    if price > 100000
      write_attribute(:budget, 100000)
    elsif price >= 20000
      write_attribute(:budget, 20000)
    else
      write_attribute(:budget, 5000)
    end
  end

private
  def add_checked_requested_services
    TechnologyType.checked.each do |tech_type|
      requested_services << RequestedService.create!(:name => tech_type.name)
    end
  end
  
  def budget_fits
    max = case budget
    when 5000
      20000
    when 20000
      100000
    when 100000
      1000000000
    else
      20000
    end
    max_budget = providers.collect { |p| p.min_budget }.max
    if max.to_i < max_budget.to_i
      errors.add(:budget, I18n.t('rfp.validations.budget_too_low'))
    end
  end

end