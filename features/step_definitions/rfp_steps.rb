Given /^a provider "([^\"]*)" with an RFP called "([^\"]*)"$/ do |provider_name, rfp|
  rfp = Factory.build(:rfp, :project_name => rfp)
  rfp.providers  << Factory.create(:provider, :company_name => provider_name, :city => "Dublin", :user => Factory.create(:user))
  rfp.save!
end

Given /^an RFP called "([^\"]*)" for "([^\"]*)"$/ do |rfp_name, provider_name|
  rfp = Factory.build(:rfp, :project_name => rfp_name)
  rfp.providers << Provider.find_by_company_name(provider_name)
  rfp.save!
end