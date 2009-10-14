require File.dirname(__FILE__) + '/spec_helper'

require File.dirname(__FILE__) + '/../lib/url_field'

class TestModel < ActiveRecord::Base
  url_field :shortcode_url

  def self.table_name
    'boojas'
  end
end

describe TestModel do
  before do
    @test_model = TestModel.new
  end
  
  it "should leave well enough alone" do
    @test_model.save
    @test_model.shortcode_url.should be_nil
  end
  
  it "should add http://" do
    @test_model.shortcode_url = "www.example.com"
    @test_model.save
    @test_model.shortcode_url.should == "http://www.example.com"
  end
  
  it "should ignore http://" do
    @test_model.shortcode_url = "http://www.example.com"
    @test_model.save
    @test_model.shortcode_url.should == "http://www.example.com"
  end
  
  it "should allow https://" do
    @test_model.shortcode_url = "https://www.example.com"
    @test_model.save
    @test_model.shortcode_url.should == "https://www.example.com"
  end

  it "should ignore https://" do
    @test_model.shortcode_url = "https://www.example.com"
    @test_model.save
    @test_model.shortcode_url.should == "https://www.example.com"
  end
  
  it "should expose the cleaned method" do
    @test_model.shortcode_url = "www.example.com"
    @test_model.cleaned_shortcode_url.should == "http://www.example.com"
  end
end