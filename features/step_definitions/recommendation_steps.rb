# given a provider "horace" with a new recommendation from "adrian"
# given a provider "horace" with an approved recommendation from "adrian"
# given a provider "horace" with a rejected recommendation from "adrian"

# given "horace" as a new recommendation from "adrian"
# given "horace" as an approved recommendation from "adrian"
# given "horace" as a rejected recommendation from "adrian"

# given "horace" as a new recommendation "crappy service" "3.days.ago"
# given "horace" as an approved recommendation "crappy service" "3.days.ago"
# given "horace" as a rejected recommendation "crappy service" "3.days.ago"


Given /^a provider "([^\"]*)" with a new recommendation from "([^\"]*)"$/ do |provider_name, the_name_of_the_guy_that_left_the_recommendation|
  recommendation = Factory.build(:recommendation, :aasm_state => 'new', :name => the_name_of_the_guy_that_left_the_recommendation, :provider => Factory.create(:provider, :company_name => provider_name))
  recommendation.save!
end

Given /^a provider "([^\"]*)" with an approved recommendation from "([^\"]*)"$/ do |provider_name, the_name_of_the_guy_that_left_the_recommendation|
  recommendation = Factory.build(:recommendation, :aasm_state => 'approved', :name => the_name_of_the_guy_that_left_the_recommendation, :provider => Factory.create(:provider, :company_name => provider_name))
  recommendation.save!
end

Given /^a provider "([^\"]*)" with a rejected recommendation from "([^\"]*)"$/ do |provider_name, the_name_of_the_guy_that_left_the_recommendation|
  recommendation = Factory.build(:recommendation, :aasm_state => 'rejected', :name => the_name_of_the_guy_that_left_the_recommendation, :provider => Factory.create(:provider, :company_name => provider_name))
  recommendation.save!
end

Given /^"([^\"]*)" has a new recommendation from "([^\"]*)"$/ do |provider_name, the_name_of_the_guy_that_left_the_recommendation|
  provider = Provider.find_by_company_name(provider_name)
  provider.recommendations << Factory.create(:recommendation, :aasm_state => 'new', :name => the_name_of_the_guy_that_left_the_recommendation, :provider => provider)
end

Given /^"([^\"]*)" has a approved recommendation from "([^\"]*)"$/ do |provider_name, the_name_of_the_guy_that_left_the_recommendation|
  provider = Provider.find_by_company_name(provider_name)
  provider.recommendations << Factory.create(:recommendation, :aasm_state => 'approved', :name => the_name_of_the_guy_that_left_the_recommendation, :provider => provider)
end

Given /^"([^\"]*)" has a rejected recommendation from "([^\"]*)"$/ do |provider_name, the_name_of_the_guy_that_left_the_recommendation|
  provider = Provider.find_by_company_name(provider_name)
  provider.recommendations << Factory.create(:recommendation, :aasm_state => 'rejected', :name => the_name_of_the_guy_that_left_the_recommendation, :provider => provider)
end

Given /^"([^\"]*)" has a new recommendation "([^\"]*)" "([^\"]*)"$/ do |provider_name, recommendation, time|
  provider = Provider.find_by_company_name(provider_name)
  provider.recommendations << Factory.create(:recommendation, :aasm_state => 'new', :endorsement => recommendation, :created_at => eval(time), :provider => provider)
end

Given /^"([^\"]*)" has an approved recommendation "([^\"]*)" "([^\"]*)"$/ do |provider_name, recommendation, time|
  provider = Provider.find_by_company_name(provider_name)
  provider.recommendations << Factory.create(:recommendation, :aasm_state => 'approved', :endorsement => recommendation, :created_at => eval(time), :provider => provider)
end

Given /^"([^\"]*)" has a rejected recommendation "([^\"]*)" "([^\"]*)"$/ do |provider_name, recommendation, time|
  provider = Provider.find_by_company_name(provider_name)
  provider.recommendations << Factory.create(:recommendation, :aasm_state => 'rejected', :endorsement => recommendation, :created_at => eval(time), :provider => provider)
end