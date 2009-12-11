require 'spec_helper'

describe CodeSample do

  @@tests_and_results = {
  'reek' => 8,
  'flay' => 72,
  'flog' => BigDecimal.new('85.2'),
  'roodi' => 0,
  'saikuro' => BigDecimal.new('5.5')
  }

  before(:all) do
    @file_contents = File.read('spec/fixtures/code_sample.rb')
    @code_sample = CodeSample.make(:code => @file_contents)
  end
  
  describe "tests" do    
    @@tests_and_results.each do |test, test_result|
      it "should run #{test}" do
        @code_sample.send(test).should == test_result
      end
    end
  end
  
  describe "#run_tests" do
    before(:all) do
      @code_sample.run_tests!
    end
    
    it "should set the test values" do
      @code_sample.aasm_state.should == "show"
    end
    
    @@tests_and_results.each do |test, test_result|
      it "should have a result for #{test}" do
        @code_sample.send("#{test}_result").should == test_result
      end
    end
  end
end
