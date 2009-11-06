class ReferenceRequest < ActiveRecord::Base

  validates_presence_of :name, :email, :message
  validates_presence_of :endorsement_id
  validate_on_create :valid_email_address
  
  before_create :create_validation_token
  after_create :send_request
  
  belongs_to :endorsement
  has_one :reference
  
  xss_terminate :except => [:email]
  
  private
  
  def send_request
    Notification.deliver_reference_request(self)
  end
  
  def create_validation_token
    self.validation_token = Authlogic::Random.friendly_token
  end
  
  def valid_email_address
    begin
      parsed_address = TMail::Address.parse(email.to_s)
      errors.add(:email, I18n.t('endorser.validations.invalid_email') ) unless parsed_address.address =~ /^[^@]*@[^\.]*\..*$/
    rescue TMail::SyntaxError
      errors.add(:email, I18n.t('endorser.validations.invalid_email') )
    end
  end

end
