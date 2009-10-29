Given /^a service category "([^\"]*)"$/ do |name|
  ServiceCategory.make(:name => name)
end

Given /^there are no service categories$/ do
  ServiceCategory.destroy_all
end
