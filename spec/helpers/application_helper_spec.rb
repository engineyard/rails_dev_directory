require File.dirname(__FILE__) + '/../spec_helper'
include ApplicationHelper

describe ApplicationHelper do
  it "should have yes for true" do
    yes_or_no(true).should == 'Yes'
  end
  
  it "should have no for false" do
    yes_or_no(false).should == 'No'
  end
  
  describe "displaying flash" do
    before do
      flash[:notice] = "Now"
    end
    
    it "should have a flash notice" do
      flash[:notice].should == "Now"
    end
    
    it "should format the flash notice" do
      display_flash.should == '<div class="notice">Now</div>'
    end
  end
end