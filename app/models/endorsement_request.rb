class EndorsementRequest < ActiveRecord::Base
  validates_presence_of :message
  validate_on_create :recipient_count
  
  attr_reader :recipient_addresses
  
  after_save :send_requests

  has_many :recipients, :class_name => 'EndorsementRequestRecipient'

  belongs_to :provider
  
  xss_terminate :except => [:recipient_addresses]
  
  def recipient_addresses=(addresses = '')
    @recipient_addresses = []
    addresses.split(%r{,\s*}).each do |email|
      recipients.build(:email => email)
      @recipient_addresses << email
    end
  end

  def send_requests
    recipients.each do |recipient|
      recipient.send_request
    end
  end

private

  def recipient_count
    errors.add(:recipients, I18n.t('endorsement_request.validations.no_recipients') ) if recipients.size == 0
    errors.add(:recipients, I18n.t('endorsement_request.validations.too_many_recipients') ) if recipients.size > 10
  end
end