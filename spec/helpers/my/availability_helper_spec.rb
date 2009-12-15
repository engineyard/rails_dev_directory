require 'spec_helper'

describe My::AvailabilityHelper do
  include My::AvailabilityHelper
  describe "#setup_availability" do
    before do
      Time.stub!(:now).and_return(Time.parse('14 December 2009'))
      Date.stub!(:today).and_return(Date.parse('14 December 2009'))
      @provider = Provider.make
      @provider.bookings << Booking.make(:date => Date.parse('2 December 2009'))
    end
    
    it "should give me the dates in order" do
      setup_availability(@provider)
      @provider.bookings.first.date.should == Date.parse('1 December 2009')
      @provider.bookings.second.date.should == Date.parse('2 December 2009')
    end
  end
end
