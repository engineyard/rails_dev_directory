#
# For Rails 2.x:
#   A copy of this file should be placed in RAILS_ROOT/initializers/
#   A file named mailer.yml should be placed in RAILS_ROOT/config/
#     See mailer.yml.sample
#

require "smtp_tls"

mailer_config = File.open("#{RAILS_ROOT}/config/mailer.yml") 
mailer_options = YAML.load(mailer_config) 
ActionMailer::Base.smtp_settings = mailer_options 
