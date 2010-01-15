module My::AvailabilityHelper
  
  def setup_availability(provider)
    (Date.today.beginning_of_month..((Date.today+2.months).end_of_month)).each do |date|
      provider.bookings.build(:date => date) unless provider.bookings.upcoming.find_by_date(date)
    end
    provider
  end

end
