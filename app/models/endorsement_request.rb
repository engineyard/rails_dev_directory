class EndorsementRequest < ActiveRecord::Base
  validates_presence_of :message
  validate_on_create :endorser_count
  
  attr_reader :endorser_addresses
  
  after_save :send_requests

  has_many :endorsers

  belongs_to :provider
  
  xss_terminate :except => [:endorser_addresses]
  
  def endorser_addresses=(addresses = '')
    @endorser_addresses = []
    addresses.split(%r{,\s*}).each do |email|
      endorsers.build(:email => email)
      @endorser_addresses << email
    end
  end

  def send_requests
    endorsers.each do |endorser|
      endorser.send_request
    end
  end

private

  def endorser_count
    errors.add(:endorsers, I18n.t('endorsement_request.validations.no_endorsers') ) if endorsers.size == 0
    errors.add(:endorsers, I18n.t('endorsement_request.validations.too_many_endorsers') ) if endorsers.size > 10
  end
end