class Notification < ActionMailer::Base

  def rfp_notification(request)
    setup_email
    subject t('email.rfp_notification.subject', :project => request.rfp.project_name)
    recipients request.provider.user.email
    body :request => request
  end

  def endorsement_request(endorsement_request, endorser)
    setup_email
    from "#{endorsement_request.provider.company_name} <sso@engineyard.com>"
    reply_to endorsement_request.provider.email
    subject t('email.endorsement_request.subject', :company_name => endorsement_request.provider.company_name)
    recipients endorser.email
    body :message => endorsement_request.message, :provider => endorsement_request.provider, :endorser => endorser
  end
  
  def endorsement_notification(endorsement)
    setup_email
    from "#{endorsement.name} <#{endorsement.email}>"
    reply_to endorsement.email
    subject t('email.endorsement_notification.subject')
    recipients endorsement.provider.email
    body(
      :endorsement => endorsement,
      :provider => endorsement.provider,
      :name => (endorsement.provider and endorsement.provider.user ? endorsement.provider.user.first_name_or_email : '')
        )
  end

  def user_welcome(user, subj = nil, message = nil)
    setup_email
    subject (subj.blank? ? t('email.user_welcome.subject') : subj)
    recipients user.email
    body :user => user, :message => message
  end

  def provider_welcome(user, subj = nil, message = nil)
    setup_email
    subject (subj.blank? ? t('email.provider_welcome.subject') : subj)
    recipients user.email
    body :user => user, :message => message
  end
  
  def setup_email
    from "#{site_config(:email_name)} <sso@engineyard.com>"
    reply_to "#{site_config(:email_address)}"
  end
  
  def password_reset_instructions(user)  
    setup_email
    subject t('email.password_reset.subject')
    recipients user.email
    sent_on Time.now
    body :user => user, :edit_password_reset_url => edit_password_reset_url(user.perishable_token)  
  end

end
