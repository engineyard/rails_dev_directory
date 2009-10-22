
if Rails.production?
  ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => site_config[:enable_starttls_auto] || false,
    :address => site_config[:smtp_address],
    :domain => site_config[:smtp_domain],
    :port => site_config[:smtp_port],
    :user_name => site_config[:smtp_user_name],
    :password => site_config[:smtp_password],
    :authentication => :login
  }
end

if Rails.version < "2.3.5"
  module ActionMailer
    class Base
      def perform_delivery_smtp(mail)
        destinations = mail.destinations
        mail.ready_to_send
        sender = (mail['return-path'] && mail['return-path'].spec) || Array(mail.from).first

        smtp = Net::SMTP.new(smtp_settings[:address], smtp_settings[:port])
        smtp.enable_starttls_auto if smtp_settings[:enable_starttls_auto] && smtp.respond_to?(:enable_starttls_auto)
        smtp.start(smtp_settings[:domain], smtp_settings[:user_name], smtp_settings[:password],
                   smtp_settings[:authentication]) do |smtp|
          smtp.sendmail(mail.encoded, sender, destinations)
        end
      end
    end
  end
end