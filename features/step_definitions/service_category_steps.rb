Given /^a service category "([^\"]*)"$/ do |name|
  ServiceCategory.make(:name => name)
end