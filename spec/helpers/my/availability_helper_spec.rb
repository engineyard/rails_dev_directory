require 'spec_helper'

describe My::AvailabilityHelper do
  include My::AvailabilityHelper
  describe "#setup_availability" do
    
    before do
      @provider = Provider.new
    end
    
    it "should give me my provider back" do
      setup_availability(@provider).should == @provider
    end
  end
end
