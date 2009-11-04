Given /^a quiz "([^\"]*)"$/ do |quiz_name|
  Quiz.make(:name => quiz_name)
end
