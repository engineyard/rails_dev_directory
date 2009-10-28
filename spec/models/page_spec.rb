require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Page do
  
  describe "#url=" do
    
    before do
      Page.stub!(:open_url).and_return(%Q[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
      <html>
          <meta name="page" content="home">
        <head])
      @page = Page.new(:url => 'http://www.railsdevelopment.com/')
    end
    
    it "should get the URL from the contents" do
      @page.url.should == 'home'
    end
    
  end
  
end