require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Request do
  before(:each) do
    @user = mock_model(User, :name => 'Paul')
    @rfp = mock_model(Rfp)
    @provider = mock_model(Provider, :user => @user)
    @request = Request.new(:rfp => @rfp, :provider => @provider)
  end

  it "should should be unread by default" do
    @request.unread?.should be_true
  end

  it "should send an email to the provider" do
    Notification.should_receive(:deliver_rfp_notification).with(@request)
    @request.save!
  end
end