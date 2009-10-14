require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RequestedService do
  before(:each) do
    @valid_attributes = {
      :rfp_id => 1,
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    RequestedService.create!(@valid_attributes)
  end
end
