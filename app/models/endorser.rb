class Endorser < ActiveRecord::Base
  validates_presence_of :email
  validate_on_create :valid_email_address

  before_create :create_validation_token
  
  belongs_to :endorsement_request
  
  xss_terminate :except => [:email]
  
  def send_request
    Notification.deliver_endorsement_request(endorsement_request, self)
  end
  
  private
  
  def create_validation_token
    self.validation_token = Authlogic::Random.friendly_token
  end
  
  def valid_email_address
    begin
      parsed_address = TMail::Address.parse(self.email)
      errors.add(:email, I18n.t('endorser.validations.invalid_email') ) unless parsed_address.address =~ /^[^@]*@[^\.]*\..*$/
    rescue TMail::SyntaxError
      errors.add(:email, I18n.t('endorser.validations.invalid_email') )
    end
  end
  
end
