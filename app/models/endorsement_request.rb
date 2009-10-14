class EndorsementRequest < ActiveRecord::Base
  validates_presence_of :recipients, :message
  validate_on_create :recipients_divisible_and_valid
  
  after_save :send_requests

  belongs_to :provider
  
  xss_terminate :except => [:recipients]
  
  def emails
    emails = []
    emails = recipients.split(%r{,\s*}) if recipients.not.blank?
    emails
  end

  def send_requests
    self.emails.each do |address|
      Notification.deliver_endorsement_request(self,address)
    end
  end

private
  
  def recipients_divisible_and_valid
    errors.add(:recipients, I18n.t('endorsement_request.validations.too_many_recipients') ) if self.emails.length > 10
    self.emails.each do |str|
      begin
        email = TMail::Address.parse(str)
      rescue TMail::SyntaxError
        errors.add(:recipients, I18n.t('endorsement_request.validations.invalid_recipients') )
      else
        errors.add(:recipients, I18n.t('endorsement_request.validations.invalid_recipients') ) unless email.address =~ /^[^@]*@[^\.]*\..*$/
      end
    end
  end
end