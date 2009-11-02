Given /^a top city "([^\"]*)" in "([^\"]*)"$/ do |city, state_country|
  if state_country.include?(',')
    state = state_country.split(',').first.strip
    country = state_country.split(',').last.strip
  else
    state = nil
    country = state_country
  end
  TopCity.create(:city => city, :state => state, :country => country)
end