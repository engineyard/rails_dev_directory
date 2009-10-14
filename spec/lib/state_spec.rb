require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe State do
  it "should get me a slug" do
    State.slug_for("FL").should == "us-florida"
  end
  
  it "should get me a path" do
    State.path_for("FL").should == "florida_path"
  end
  
  it "should get me a state from a slug" do
    State.from_slug('florida').name.should == "Florida"
  end
end