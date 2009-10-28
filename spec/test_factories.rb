require 'factory_girl'

Factory.define :test_provider, :class => Provider do |provider|
  # company_name:string street_address:string city:string state:string postal_code:string country:string phone_number:string email:string company_size:integer
  provider.company_name "Hyper Tiny"
  provider.marketing_description "Fast, Cheap, and Out of Control"
  provider.street_address "Dublin Avenue"
  provider.city "Dublin"
  provider.state_province "N/A"
  provider.postal_code "Dublin 3"
  provider.country "IE"
  provider.phone_number "+353 111111"
  provider.email "it@hypertiny.net"
  provider.company_url "http://hypertiny.net"
  provider.company_size 11
  provider.aasm_state "inactive"

  provider.association :user, :factory => :test_user
end

Factory.define :test_rfp, :class => Rfp do |rfp|
  rfp.first_name "Paul"
  rfp.last_name "Campbell"
  rfp.company_name "Paul Campbell"
  rfp.email "paul@rslw.com"
  rfp.phone_number "0879148162"
  rfp.project_name "Nice work finger"
  rfp.nda_required false
  rfp.project_description "It's such an interesting project, what do you think?"
  rfp.budget 5000
  rfp.due_date '2020-12-20'
  rfp.time_zone "Dublin"
  rfp.office_location "Dublin"
  rfp.general_liability_insurance true
  rfp.professional_liability_insurance false
  rfp.additional_services
end

Factory.define :portfolio_item do |portfolio_item|
  portfolio_item.name "Tautologistics"
  portfolio_item.url "http://tautologistics.com/"
  portfolio_item.description "6 week project and not a single casualty. Except the one, obviously."
  Year Completed "2004"

  portfolio_item.association :provider, :factory => :provider
end

Factory.define :test_request, :class => Request do |request|
  request.association :provider, :factory => :test_provider
  request.association :rfp, :factory => :test_rfp
end

Factory.define :test_endorsement_request, :class => EndorsementRequest do |endorsement_request|
  endorsement_request.message "Hold yer horses, big shot."
  endorsement_request.recipients "Kate Rusby <krusby@yorkshire.co.uk"

  endorsement_request.association :provider, :factory => :test_provider
end

Factory.define :test_recommendation, :class => Recommendation do |recommendation|
  recommendation.name "Brian"
  recommendation.company "dufilmmakers"
  recommendation.year_hired "2007"
  recommendation.position "Grand Pooh-bah"
  recommendation.email "btflanagan@gmail.com"
  recommendation.endorsement "A++++!! Would use again!"
  recommendation.url "http://www.brianflanagan.org"
end

Factory.define :test_user, :class => User do |user|
  user.password 'testtest'
  user.password_confirmation 'testtest'
  user.email 'test@test.com'
  user.first_name 'Paul'
  user.last_name 'Campbell'
end

Factory.define(:technology_type) do |t|
  t.name "Ruby on Rails"
  t.checked true
end

Factory.define :rfp do |rfp|
  rfp.first_name "Paul"
  rfp.last_name "Campbell"
  rfp.company_name "Paul Campbell"
  rfp.email "paul@rslw.com"
  rfp.phone_number "0879148162"
  rfp.project_name "Nice work finger"
  rfp.nda_required false
  rfp.project_description "It's such an interesting project, what do you think?"
  rfp.budget 5000
  rfp.start_date '2020-12-01'
  rfp.duration '3 weeks'
  rfp.due_date '2020-12-20'
  rfp.time_zone "Dublin"
  rfp.office_location "Dublin"
  rfp.postal_code "90210"
  rfp.general_liability_insurance true
  rfp.professional_liability_insurance false
  rfp.additional_services
end
