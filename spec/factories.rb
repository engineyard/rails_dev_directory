Factory.define :provider do |provider|
  # company_name:string street_address:string city:string state:string postal_code:string country:string phone_number:string email:string company_size:integer
  provider.company_name "Hyper Tiny"
  provider.marketing_description "Fast, Cheap, and Out of Control"
  provider.street_address "Dublin Avenue"
  provider.city "Dublin"
  provider.state_province "NA"
  provider.postal_code "Dublin 3"
  provider.country "IE"
  provider.phone_number "+353 111111"
  provider.email "it@hypertiny.net"
  provider.company_url "http://hypertiny.net"
  provider.company_size 11
  provider.aasm_state "active"
end

Factory.define :user do |user|
  user.sequence(:email) {|n| "paul#{n}@gmail.com" }
  user.password 'testtest'
  user.password_confirmation 'testtest'
  user.first_name 'Paul'
  user.last_name 'Campbell'
end

Factory.define "paul", :class => User do |user|
  user.first_name 'Paul'
  user.last_name 'Campbell'
  user.password 'railsproshops'
  user.password_confirmation 'railsproshops'
  user.email 'test@test.com'
end

Factory.define "obie", :class => User do |user|
  user.first_name 'Obie'
  user.last_name 'Fernandex'
  user.password 'testtest'
  user.password_confirmation 'testtest'
  user.email 'obie@hashrocket.com'
end

Factory.define "Billow", :class => User do |user|
  user.first_name 'Billow'
  user.last_name 'Buxtonious'
  user.password 'buxtonbuxton'
  user.password_confirmation 'buxtonbuxton'
  user.email 'billowlowha@test.com'
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

Factory.define :admin_user, :class => User do |user|
  user.password "mightyadmin"
  user.password_confirmation "mightyadmin"
  user.email "administrator@engineyard.com"
  user.admin true
end

Factory.define(:endorsement) do |r|
  r.name "John"
  r.email "john@john.net"
  r.position "animal wrangler"
  r.year_hired "2008"
  r.company "Johnso"
  r.url "jobso.com"
  r.message "Neat"
end

Factory.define :portfolio_item do |portfolio_item|
  portfolio_item.name "Tautologistics"
  portfolio_item.url "http://tautologistics.com/"
  portfolio_item.description "6 week project and not a single casualty. Except the one, obviously."
  portfolio_item.year_completed "2004"

  portfolio_item.association :provider, :factory => :provider
end

Factory.define(:page) do |p|
  p.title "Test"
  p.url "test"
  p.content "Content"
end

Factory.define(:technology_type) do |t|
  t.name "Ruby on Rails"
  t.checked true
end