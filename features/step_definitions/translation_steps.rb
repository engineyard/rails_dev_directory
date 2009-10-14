Then /^I should see the translation for "([^\"]*)"$/ do |key|
  response.should contain(I18n.t(key))
end