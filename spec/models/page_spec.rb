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
  
  describe "#robots" do
    
    before do
      @page = Page.make_unsaved
    end
    
    it "should have no robots" do
      @page.robots.should be_blank
    end
    
    it "should have nofollow by itself" do
      @page.nofollow = true
      @page.robots.should == 'nofollow'
    end
    
    it "should have both nofollow and noindex" do
      @page.nofollow = true
      @page.noindex = true
      @page.robots.should == 'noindex, nofollow'
    end
    
  end
  
end