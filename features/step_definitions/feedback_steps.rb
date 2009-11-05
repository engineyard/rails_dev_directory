Then /^the feedback about "([^\"]*)" should be (new|approved|rejected)$/ do |project_name, state|
  Feedback.find_by_project(project_name).state.should eql(state)
end

Given /^the provider "([^\"]*)" has some (new|accepted|rejected) feedback "([^\"]*)"$/ do |provider_name, state, feedback|
  provider = Provider.find_by_company_name(provider_name)
  Feedback.make(:provider => provider, :message => feedback, :aasm_state => state)
end
