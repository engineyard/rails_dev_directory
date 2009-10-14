require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include RfpsHelper

describe RfpsHelper do
  
  before do
    @rfp = Rfp.new
  end
  
  it "should return a new rfp" do
    setup_rfp(@rfp).should == @rfp
  end

end
