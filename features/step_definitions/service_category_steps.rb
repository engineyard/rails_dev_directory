Given /^a service category "([^\"]*)"$/ do |name|
  ServiceCategory.make(:name => name)
end

Given /^the service category "([^\"]*)" has proficiency$/ do |name|
  ServiceCategory.find_by_name(name).update_attribute(:proficiency, true)
end

Given /^there are no service categories$/ do
  ServiceCategory.destroy_all
end
