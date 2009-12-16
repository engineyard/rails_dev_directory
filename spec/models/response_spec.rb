require 'spec_helper'

describe Response do
  before(:each) do
    @valid_attributes = {
      :provider_id => 1,
      :question_id => 1,
      :answer_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Response.create!(@valid_attributes)
  end
end
