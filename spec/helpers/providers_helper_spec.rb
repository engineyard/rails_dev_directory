require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include ProvidersHelper

describe ProvidersHelper do
  
  before do
    @provider = Provider.create!(:company_name => "The big misfits", :city => 'Test city', :email => 'paul@rslw.com', :company_url => 'http://www.rslw.com', :company_size => 11, :hourly_rate => 10000)
  end
  
  it "should setup the provider users when generating the form" do
    setup_provider(@provider).should == @provider
    @provider.users.should_not be_empty
  end
  
  it "should format the price nicely if provider isn't specified" do
    price(@provider.hourly_rate).should == "$10,000"
  end
  
  it "should format the price nicely if provider isn't specified" do
    @provider.hourly_rate = 150.51
    price(@provider.hourly_rate).should == "$150.51"
  end
  
  it "should format the price nicely if nil" do
    price(nil).should == '-'
  end
  
  it "should format the price nicely if blank" do
    price('').should == '-'
  end
  
  it "should format the price nicely if 0" do
    price(0).should == '-'
  end
  
  it "should give me a nice number" do
    number_to_currency(10000.0, :precision => 0).should == "$10,000"
  end

end