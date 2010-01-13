require 'spec_helper'

describe Sitting do
  before(:each) do
    @valid_attributes = {
      :quiz_id => 1,
      :provider_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Sitting.create!(@valid_attributes)
  end
end
