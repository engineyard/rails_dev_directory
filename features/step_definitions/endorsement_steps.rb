# given a provider "horace" with a new recommendation from "adrian"
# given a provider "horace" with an approved recommendation from "adrian"
# given a provider "horace" with a rejected recommendation from "adrian"

# given "horace" as a new recommendation from "adrian"
# given "horace" as an approved recommendation from "adrian"
# given "horace" as a rejected recommendation from "adrian"

# given "horace" as a new recommendation "crappy service" "3.days.ago"
# given "horace" as an approved recommendation "crappy service" "3.days.ago"
# given "horace" as a rejected recommendation "crappy service" "3.days.ago"


Given /^a provider "([^\"]*)" with an? (new|approved|rejected) recommendation from "([^\"]*)"$/ do |provider_name, endorsement_state, endorser_name|
  provider = Provider.make(:company_name => provider_name)
  Recommendation.make(:aasm_state => endorsement_state, :provider => provider, :name => endorser_name)
end

Given /^"([^\"]*)" has an? (new|approved|rejected) recommendation from "([^\"]*)"$/ do |provider_name, endorsement_state, endorser_name|
  provider = Provider.find_by_company_name(provider_name)
  Recommendation.make(:aasm_state => endorsement_state, :provider => provider, :name => endorser_name)
end

Given /^"([^\"]*)" has an? (new|approved|rejected) recommendation "([^\"]*)" "([^\"]*)"$/ do |provider_name, endorsement_state, endorsement, time|
  provider = Provider.find_by_company_name(provider_name)
  Recommendation.make(:aasm_state => endorsement_state, :provider => provider, :endorsement => endorsement, :created_at => eval(time))
end

Given /^"([^\"]*)" have requested "([^\"]*)" submit an endorsement$/ do |provider_name, endorser_email|
  provider = Provider.find_by_company_name(provider_name)
  EndorsementRequest.make(:provider => provider, :endorser_addresses => endorser_email)
end

When /^"([^\"]*)" follows the emailed endorsement link$/ do |endorser_email|
  open_email(endorser_email)
  click_first_link_in_email
end
