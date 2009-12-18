require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include RfpsHelper

describe RfpsHelper do
  
  before do
    @rfp = Rfp.new
  end
  
  it "should return a new rfp" do
    setup_rfp(@rfp).should == @rfp
  end
  
  describe "#rfp_hours" do
    it "should accept a minimum" do
      rfp_hours('1-').should == 'More Than 1 Hours/Week'
    end
    
    it "should accept a maximum" do
      rfp_hours('-2').should == "Less Than 2 Hours/Week"
    end
    
    it "should accept a range" do
      rfp_hours('2-4').should == "2-4 Hours/Week"
    end
  end
  
  describe "#rfp_duration" do
    it "should accept a minimum" do
      rfp_duration('1-').should == 'More Than 1 Week'
    end
    
    it "should accept a maximum" do
      rfp_duration('-2').should == "Less Than 2 Weeks"
    end
    
    it "should accept a range" do
      rfp_duration('2-4').should == "2-4 Weeks"
    end
  end

end
