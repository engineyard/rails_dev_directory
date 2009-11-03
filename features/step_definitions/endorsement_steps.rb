# given a provider "horace" with a new endorsement from "adrian"
# given a provider "horace" with an approved endorsement from "adrian"
# given a provider "horace" with a rejected endorsement from "adrian"

# given "horace" as a new endorsement from "adrian"
# given "horace" as an approved endorsement from "adrian"
# given "horace" as a rejected endorsement from "adrian"

# given "horace" as a new endorsement "crappy service" "3.days.ago"
# given "horace" as an approved endorsement "crappy service" "3.days.ago"
# given "horace" as a rejected endorsement "crappy service" "3.days.ago"


Given /^a provider "([^\"]*)" with an? (new|approved|rejected) endorsement from "([^\"]*)"$/ do |provider_name, endorsement_state, endorser_name|
  provider = Provider.make(:company_name => provider_name)
  Endorsement.make(:aasm_state => endorsement_state, :provider => provider, :name => endorser_name)
end

Given /^"([^\"]*)" has an? (new|approved|rejected) endorsement from "([^\"]*)"$/ do |provider_name, endorsement_state, endorser_name|
  provider = Provider.find_by_company_name(provider_name)
  Endorsement.make(:aasm_state => endorsement_state, :provider => provider, :name => endorser_name)
end

Given /^"([^\"]*)" has an? (new|approved|rejected) endorsement "([^\"]*)" "([^\"]*)"$/ do |provider_name, endorsement_state, endorsement, time|
  provider = Provider.find_by_company_name(provider_name)
  Endorsement.make(:aasm_state => endorsement_state, :provider => provider, :endorsement => endorsement, :created_at => eval(time))
end

Given /^"([^\"]*)" have requested "([^\"]*)" submit an endorsement$/ do |provider_name, endorser_email|
  provider = Provider.find_by_company_name(provider_name)
  EndorsementRequest.make(:provider => provider, :recipient_addresses => endorser_email)
end

When /^"([^\"]*)" follows the emailed endorsement link$/ do |endorser_email|
  open_email(endorser_email)
  click_first_link_in_email
end
