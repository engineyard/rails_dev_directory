require 'machinist/active_record'
require 'faker'
require 'sham'

Sham.name  { Faker::Name.name }
Sham.url   { "http://#{Faker::Internet.domain_name}/" }
Sham.email { Faker::Internet.email }
Sham.title { Faker::Lorem.sentence }
Sham.body  { Faker::Lorem.paragraph }
Sham.message { Faker::Lorem.paragraph }
Sham.content { Faker::Lorem.paragraph }
Sham.date { Time.now }
Sham.code { Faker::Lorem.words.first }
Sham.price { (1..100).to_a.rand }
Sham.password { Faker::Company.bs }
Sham.city { Faker::Address.city }

User.blueprint do
  name
  email
  password
end

Service.blueprint do
  category { ServiceCategory.make }
  name
end

ServiceCategory.blueprint do
  name
end

Provider.blueprint do
  email
  company_url { Sham.url }
  city
end

Recommendation.blueprint do
  name
  year_hired { Time.now.strftime('%Y') }
  position { Sham.title }
  company { Sham.name }
  recipient_email = Sham.email
  email { recipient_email }
  url
  endorsement { Sham.body }
  endorsement_request_recipient { EndorsementRequestRecipient.make(:email => recipient_email) }
end

EndorsementRequest.blueprint do
  message
  recipients { "#{Sham.name} <#{Sham.email}>" }
end

EndorsementRequestRecipient.blueprint do
  email
end
