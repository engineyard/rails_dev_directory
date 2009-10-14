require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rfp do
  before(:each) do
    TechnologyType.destroy_all
    @technology_type = Factory.create(:technology_type)
    @rfp = Factory.build(:rfp)
  end

  it "should create a new instance given valid attributes" do
    @rfp.save!
    @rfp.requested_services.collect { |c| c.name }.should == [@technology_type.name]
  end
  
  describe "setting the budget" do
    before do
      @rfp = Rfp.new(:budget => 90000)
    end
    
    it "should set budget to 20000" do
      @rfp.budget.should == 20000
    end
  end
end

describe Rfp, "where the budget is too big" do
  before(:each) do
    @provider = Factory.create(:provider, :min_budget => 25000)
    @rfp = Rfp.new(:budget => 5000)
    @rfp.providers << @provider
  end
  
  it "should be invalid" do
    @rfp.valid?
    @rfp.should have(1).errors_on(:budget)
  end
end