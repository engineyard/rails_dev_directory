require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Recommendation do
  before(:each) do
    @provider = Factory.create(:test_provider)
  end

  it "should activate the provider if it is the third recommendation" do
    Notification.should_receive(:deliver_endorsement_notification).exactly(3).times
    @provider.recommendations << Factory.create(:test_recommendation, :provider => @provider, :aasm_state => 'approved')
    @provider.status.should == 'inactive'
    @provider.recommendations << Factory.create(:test_recommendation, :provider => @provider, :aasm_state => 'approved')
    @provider.status.should == 'inactive'
    @provider.recommendations << Factory.create(:test_recommendation, :provider => @provider, :aasm_state => 'approved')
    @provider.status.should == 'active'
  end
end
