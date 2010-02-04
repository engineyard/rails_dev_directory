require 'spec_helper'

describe Sitting do
  before do
    @quiz = mock_model(Quiz, :attempts => 1)
    @provider = Provider.make
    @sitting = Sitting.make(:quiz => @quiz, :provider => @provider)
  end
  
  it "shouldn't allow a new sitting" do
    @sitting = Sitting.new(:quiz => @quiz, :provider => @provider)
    @sitting.should_not be_valid
  end
end
