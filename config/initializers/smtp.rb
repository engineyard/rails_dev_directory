
if Rails.production?
  ActionMailer::Base.smtp_settings = {
    :address => site_config[:smtp_address],
    :domain => site_config[:smtp_domain],
    :port => site_config[:smtp_port],
    :user_name => site_config[:smtp_user_name],
    :password => site_config[:smtp_password],
    :authentication => :login
  }
end