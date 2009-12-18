Given /^a provider "([^\"]*)"$/ do |provider_name|
  Factory.create(:provider,:company_name => provider_name, :city => "Dublin")
end

Given /^the provider "([^\"]*)" has the email address "([^\"]*)"$/ do |provider_name, email|
  Provider.find_by_company_name(provider_name).update_attribute(:email, email)
end

Given /^"([^\"]*)" provides "([^\"]*)"$/ do |provider_name, service_name|
  Provider.find_by_company_name(provider_name).services << Service.find_by_name(service_name)
end

Given /^"([^\"]*)" has a minimum budget of "([^\"]*)"$/ do |provider_name, budget|
  Provider.find_by_company_name(provider_name).update_attribute(:min_budget, budget)
end

Given /^"([^\"]*)" has an hourly rate of "([^\"]*)"$/ do |provider_name, hourly_rate|
  Provider.find_by_company_name(provider_name).update_attribute(:hourly_rate, hourly_rate)
end

When /^I fill in the provider sign up form for "([^\"]*)"$/ do |provider_name|
  fill_in("Email", :with => "paul@rslw.com")
  fill_in("Password", :with => "password")
  fill_in("Retype password", :with => "password")
  fill_in("Business Name", :with => "#{provider_name}")
  fill_in("Website", :with => "http://www.rslw.com")
  fill_in("City", :with => "Dublin")
end

When /^I fill in the "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

Given /^a user "([^\"]*)" belonging to the "([^\"]*)" provider$/ do |username, provider|
  user = Factory.build(username)
  user.provider = Provider.find_by_company_name(provider)
  user.save!
end

Given /^a(?:n (active|inactive))? provider "([^\"]*)" belonging to "([^\"]*)"$/ do |state, provider, email|
  provider = Factory.create(:provider, :company_name => provider)
  provider.update_attribute(:aasm_state, state) if state
  user = Factory.create(:user, :email => email)
  provider.update_attribute(:user, user)
  user.update_attribute(:provider, provider)
end

Given /^an "([^\"]*)" provider "([^\"]*)"$/ do |state, provider|
  Factory.create(:provider, :company_name => provider, :aasm_state => state, :user => Factory.create(:user))
end

When /^I check the "([^\"]*)" checkbox$/ do |provider_name|
  provider = Provider.find_by_company_name(provider_name)
  check("provider_#{provider.id}")
end

Then /^the provider "([^\"]*)" checkbox should be checked$/ do |provider_name|
  provider = Provider.find_by_company_name(provider_name)
  field_with_id("provider_#{provider.id}").should be_checked
end

Given /^a portfolio item "([^\"]*)" belonging to the "([^\"]*)" provider$/ do |portfolio_item_name, provider|
  Factory.create(:portfolio_item, :name => portfolio_item_name, :provider => Provider.find_by_company_name(provider))
end

Given /^"([^\"]*)" is based in "([^\"]*)"$/ do |company_name, location|
  Provider.find_by_company_name(company_name).update_attributes(
    :state_province => location == "nowhere" ? "" : location.split(',').first.strip,
    :country => location == "nowhere" ? "" : location.split(',').last.strip)
end

Then /^the provider "([^\"]*)" should be (active|inactive)$/ do |provider_name, state|
  provider = Provider.find_by_company_name(provider_name)
  provider.aasm_state.should eql(state)
end

Given /^provider "([^\"]*)" is available for projects between "([^\"]*)" and "([^\"]*)" weeks in length$/ do |provider_name, min_length, max_length|
  Provider.find_by_company_name(provider_name).update_attributes(:min_project_length => min_length.to_i * 30, :max_project_length => max_length.to_i * 30)
end

Given /^provider "([^\"]*)" likes to work between "([^\"]*)" and "([^\"]*)" hours per week$/ do |provider_name, min, max|
  Provider.find_by_company_name(provider_name).update_attributes(:min_hours => min, :max_hours => max)
end

Then /^the provider "([^\"]*)" should belong to "([^\"]*)"$/ do |provider_name, email|
  user = User.find_by_email(email)
  provider = Provider.find_by_company_name(provider_name)
  provider.user.should == user
end