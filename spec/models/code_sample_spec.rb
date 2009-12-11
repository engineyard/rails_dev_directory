require 'spec_helper'

describe CodeSample do
  before do
    @file_contents = File.read('spec/fixtures/code_sample.rb')
    @code_sample = CodeSample.make(:code => @file_contents)
  end
  
  it "should run reek" do
    @code_sample.reek.should == 8
  end
  
  it "should run flay" do
    @code_sample.flay.should == 72
  end
  
  it "should run flog" do
    @code_sample.flog.should == 85.2
  end
  
  it "should run roodi" do
    @code_sample.roodi.should == 0
  end
  
  it "should run saikuru" do
    @code_sample.saikuro.should == 5.5
  end
end
