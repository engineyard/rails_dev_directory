require File.dirname(__FILE__) + '/spec_helper'

class User < ActiveRecord::Base
  def self.table_name; 'boojas'; end
  can_has?
end

class GoodThing < ActiveRecord::Base
  def self.table_name; 'boojas'; end
  
  attr_accessor :user
end

class BadThing < ActiveRecord::Base
  def self.table_name; 'boojas'; end
  
  attr_accessor :user
end

class SillyThing < ActiveRecord::Base
  def self.table_name; 'boojas'; end
  
  attr_accessor :user
  
  def can_read?(user)
    false
  end
end

describe "Can Has" do
  before do
    @user = User.new
  end
  
  it "should let the user have the good thing" do
    @user.can_has?(GoodThing.new(:user => @user)).should == true
  end
  
  it "should let the user have the bad thing" do
    @user.can_has?(BadThing.new(:user => mock_model(User))).should == true
  end
  
  it "should let the user have the good thing" do
    @user.can_read?(GoodThing.new(:user => @user)).should == true
  end
  
  it "should let the user have the bad thing" do
    @user.can_read?(BadThing.new(:user => mock_model(User))).should == true
  end

  it "should let the user edit the good thing" do
    @user.can_edit?(GoodThing.new(:user => @user)).should == true
  end
  
  it "should not let the user edit the good thing" do
    @user.can_edit?(BadThing.new(:user => mock_model(User))).should == false
  end
  
  it "should let the user delete the good thing" do
    @user.can_delete?(GoodThing.new(:user => @user)).should == true
  end
  
  it "should not let the user delete the good thing" do
    @user.can_delete?(BadThing.new(:user => mock_model(User))).should == false
  end
  
  it "should let the user have the silly thing" do
    @user.can_read?(SillyThing.new(:user => @user)).should == false
  end
  
  it "should let the user have the silly thing" do
    @user.can_read?(SillyThing.new(:user => mock_model(User))).should == false
  end
end