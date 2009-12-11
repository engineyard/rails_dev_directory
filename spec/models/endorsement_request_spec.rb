require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EndorsementRequest do
  before(:each) do
    @valid_emails = "paul@rslw.com, btflanagan@gmail.com, trice@ibma.org"
    @complex_emails = "Paul Campbell <paul@rslw.com>, btflanagan@gmail.com, Tony Rice <trice@ibma.org>"
    @too_many_emails = "paul@rslw.com, btflanagan@gmail.com, trice@ibma.org, rand@rslw.com, henry@gmail.com, tstafford@ibma.org, anton@rslw.com, mary@gmail.com, tobrien@ibma.org, alfred@rslw.com, art@gmail.com, nblake@ibma.org"
    @endorsement_request = EndorsementRequest.new(:message => "Hi there")
  end

  it "should have an empty array of emails first" do
    @endorsement_request.endorsers.collect(&:email).should be_empty
  end
  
  it "should accept emails as a string and convert them to an array" do
    @endorsement_request.endorser_addresses = @valid_emails
    @endorsement_request.endorsers.collect(&:email).should == ["paul@rslw.com", "btflanagan@gmail.com", "trice@ibma.org"]
  end

  it "should accept complex emails as a string and convert them to an array" do
    @endorsement_request.endorser_addresses = @complex_emails
    @endorsement_request.endorsers.collect(&:email).should == ["Paul Campbell <paul@rslw.com>", "btflanagan@gmail.com", "Tony Rice <trice@ibma.org>"]
  end
  
  it "shouldn't be valid without emails" do
    @endorsement_request.should_not be_valid
  end
  
  it "should be valid with valid emails" do
    @endorsement_request.endorser_addresses = @valid_emails
    @endorsement_request.should be_valid
  end

  it "should be valid with valid complex emails" do
    @endorsement_request.endorser_addresses = @complex_emails
    @endorsement_request.should be_valid
  end

  it "should be invalid with greater than ten valid emails" do
    @endorsement_request.endorser_addresses = @too_many_emails
    @endorsement_request.should_not be_valid
  end
  
  it "should be invalid with invalid emails" do
    @endorsement_request.endorser_addresses = "paul, brian"
    @endorsement_request.should_not be_valid
  end

  it "should be invalid with some invalid emails" do
    @endorsement_request.endorser_addresses = "paul, brian@gmail.com"
    @endorsement_request.should_not be_valid
  end
  
  it "should send email to paul, brian, and tony" do
    Notification.should_receive(:deliver_endorsement_request).with(@endorsement_request, an_instance_of(Endorser)).exactly(3).times
    @endorsement_request.endorser_addresses = @valid_emails
    @endorsement_request.save!
  end

  it "should send email to paul, brian, and tony, regardless of entry format" do
    Notification.should_receive(:deliver_endorsement_request).with(
      @endorsement_request, an_instance_of(Endorser)).exactly(3).times
    @endorsement_request.endorser_addresses = @complex_emails
    @endorsement_request.save!
  end
end
