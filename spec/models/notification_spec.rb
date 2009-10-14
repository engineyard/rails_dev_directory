require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Notification do
  it "should create the subject correctly for an rfp notification" do
    @request = Factory.build(:test_request)
    @request.stub!(:id).and_return(1)
    @notification = Notification.create_rfp_notification(@request)
    @notification.subject.should match(/Nice work finger/)
  end

  it "should create the subject correctly for an endorsement request" do
    @endorsement_request = Factory.build(:test_endorsement_request)
    @endorsement_request.stub!(:id).and_return(1)
    @notification = Notification.create_endorsement_request(@endorsement_request,@endorsement_request.emails.first)
    @notification.subject.should match(/Can you endorse Hyper Tiny?/)
  end

  it "should create the recipient correctly for a user welcome" do
    @user = Factory.build(:user)
    @user.perishable_token = '123123'
    @user.stub!(:id).and_return(1)
    @notification = Notification.create_user_welcome(@user)
    @notification.to.first.should == @user.email
  end
  
  it "should create the message if it's custom for user" do
    @user = Factory.build(:user)
    @user.stub!(:id).and_return(1)
    @notification = Notification.create_user_welcome(@user, "this", 'test')
    @notification.subject.should == 'this'
  end
  
  it "should create the message if it's custom for provider" do
    @user = Factory.build(:user)
    @user.stub!(:id).and_return(1)
    @notification = Notification.create_provider_welcome(@user, "this", 'test')
    @notification.subject.should == 'this'
    @notification.body.should == 'test'
  end
end