require 'machinist/active_record'
require 'faker'
require 'sham'

Sham.name  { Faker::Name.name }
Sham.company { Faker::Company.name }
Sham.url   { "http://#{Faker::Internet.domain_name}/" }
Sham.email { Faker::Internet.email }
Sham.title { Faker::Lorem.sentence }
Sham.body  { Faker::Lorem.paragraph }
Sham.message { Faker::Lorem.paragraph }
Sham.content { Faker::Lorem.paragraph }
Sham.project { Faker::Company.bs }
Sham.date { Time.now }
Sham.code { Faker::Lorem.words.first }
Sham.price { (1..100).to_a.rand }
Sham.password { Faker::Company.bs }
Sham.city { Faker::Address.city }
Sham.position { ['CEO', 'Developer', 'Manager'].rand }

User.blueprint do
  first_name {Sham.name}
  last_name {Sham.name}
  email
  password 'xxxxxx'
  password_confirmation 'xxxxxx'
end

Service.blueprint do
  category { ServiceCategory.make }
  name
  priority 2
end

ServiceCategory.blueprint do
  name
end

Provider.blueprint do
  email
  company_url { Sham.url }
  company_name { Sham.name }
  city
end

Endorsement.blueprint do
  name
  year_hired { Time.now.strftime('%Y') }
  position { Sham.title }
  company
  email
  url
  endorsement { Sham.body }
  endorser { Endorser.make(:email => email) }
end

EndorsementRequest.blueprint do
  message
  endorsers { "#{Sham.name} <#{Sham.email}>" }
end

Endorser.blueprint do
  email
end

Quiz.blueprint do
  name
  total_questions 2
  questions_per_quiz 1
  options_per_question 2
  skill_level 'beginner'
end

Question.blueprint do
  text { Sham.content }
end

Answer.blueprint do
  text { Sham.content }
end

Feedback.blueprint do
  name
  email
  company
  position
  project
  year_hired { Time.now.strftime('%Y') }
  message
end

Rfp.blueprint do
  project_name "Howdyee"
  first_name { Sham.name }
  last_name { Sham.name }
  email
end

CodeSample.blueprint do
  name
  code "class Woo; end"
end

Booking.blueprint {}

Sitting.blueprint {}