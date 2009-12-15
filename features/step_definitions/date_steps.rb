Given /^the date is "([^\"]*)"$/ do |date|
  Time.stub!(:now).and_return(Time.parse(date))
  Date.stub!(:today).and_return(Date.parse(date))
end