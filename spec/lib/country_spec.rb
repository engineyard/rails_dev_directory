require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Country do
  it "should get me a slug" do
    Country.slug_for("IE").should == "ireland"
  end
  
  it "should get me a path" do
    Country.path_for("US").should == 'united_states_path'
  end
  
  it "should get me a name" do
    Country.from_slug('ireland').name.should == "Ireland"
    Country.from_slug('ireland').code.to_s.should == "IE"
  end
  
  it "should build me ordering SQL" do
    I18n.stub!(:t).with('countries').and_return({:NA=>"Na'mibia", :AZ=>"Azerbaijan", :TV=>"Tuvalu"})
    Country.order_sql.should include("IF('NA', 'Na\\'mibia'")
  end
end