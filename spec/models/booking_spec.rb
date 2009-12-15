require 'spec_helper'

describe Booking do
  before(:each) do
    @valid_attributes = {
      :provider_id => 1,
      :date => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    Booking.create!(@valid_attributes)
  end
end
