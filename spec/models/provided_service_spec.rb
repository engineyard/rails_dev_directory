require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProvidedService do
  before(:each) do
    @valid_attributes = {
      :technology_type_id => 1,
      :provider_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ProvidedService.create!(@valid_attributes)
  end
end
