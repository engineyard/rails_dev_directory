Given /^provider "([^\"]*)" is booked up for "([^\"]*)"$/ do |provider_name, month|
  month = Date.parse(month)
  provider = Provider.find_by_company_name(provider_name)
  (month.beginning_of_month..month.end_of_month).each do |day|
    provider.bookings << Booking.make(:date => day)
  end
end