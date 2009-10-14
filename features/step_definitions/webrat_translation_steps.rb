require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

When /^I press "([^\"]*)" translation$/ do |button|
  click_button(I18n.t(button))
end

When /^I follow "([^\"]*)" translation$/ do |link|
  click_link(I18n.t(link))
end

When /^I fill in "([^\"]*)" translation with "([^\"]*)"$/ do |field, value|
  fill_in(I18n.t(field), :with => value) 
end

When /^I select "([^\"]*)" from "([^\"]*)" translation$/ do |value, field|
  select(I18n.t(value), :from => field) 
end

When /^I check "([^\"]*)" translation$/ do |field|
  check(I18n.t(field)) 
end

When /^I uncheck "([^\"]*)" translation$/ do |field|
  uncheck(I18n.t(field)) 
end

When /^I choose "([^\"]*)" translation$/ do |field|
  choose(I18n.t(field))
end

When /^I attach the file at "([^\"]*)" to "([^\"]*)" translation$/ do |path, field|
  attach_file(I18n.t(field), path)
end

Then /^I should see "([^\"]*)" translation$/ do |text|
  response.should contain(I18n.t(text))
end

Then /^I should not see "([^\"]*)" translation$/ do |text|
  response.should_not contain(I18n.t(text))
end