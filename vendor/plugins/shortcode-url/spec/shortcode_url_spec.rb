require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/shortcode_url'

class TestModel < ActiveRecord::Base
  shortcode_url
  
  attr_accessor :beeny
  
  def self.table_name
    'boojas'
  end
  
  def after_initialize
    self.beeny ||= 'yay!'
  end
end

describe "a model with a shortcode url" do
  before do
    @test = TestModel.create
  end
  
  it "should keep the same code" do
    shortcode = @test.shortcode_url
    @test.save
    @test.shortcode_url.should == shortcode
  end
  
  it "should have a trigger method" do
    @test.create_shortcode_url.should be_a_kind_of(String)
  end
  
  it "should have a string as short code" do
    @test.shortcode_url.should be_a_kind_of(String)
  end
  
  it "should have a 4 digit short code" do
    @test.shortcode_url.size.should == 4
  end
  
  it "should have a 4 digit short code" do
    @test.shortcode_url.should be_a_kind_of(String)
  end
  
  it "should still have an after_initialize" do
    @test.beeny.should == 'yay!'
  end
end

class TestLongModel < ActiveRecord::Base
  shortcode_url :length => 20
  
  def self.table_name
    'boojas'
  end
end

describe "a long version" do
  before do
    @test = TestLongModel.create
  end

  it "should have a really long shortcode_url" do
    @test.shortcode_url.size.should == 20
  end
end