require 'spec_helper'

describe TopCity do
  before(:each) do
    @valid_attributes = {
      :city => "value for city",
      :country => "value for country",
      :position => 1
    }
  end

  it "should create a new instance given valid attributes" do
    TopCity.create!(@valid_attributes)
  end
end
