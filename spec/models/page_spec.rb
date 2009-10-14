require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Page do
  before(:each) do
    @valid_attributes = {
      :title => "test",
      :url => "test"
    }
  end

  it "should create a new instance given valid attributes" do
    page = Page.new(@valid_attributes)
    page.url = "test"
    page.save!
  end
end
