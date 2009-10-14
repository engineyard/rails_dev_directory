# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  fixtures :users
  
  describe "first name or email" do
    it "should return email if no first name" do
      User.new(:email => 'paul@rslw.com').first_name_or_email.should == 'paul'
    end
    
    it "should return first name if present" do
      User.new(:email => 'paul@rslw.com', :first_name => "Paul").first_name_or_email.should == 'Paul'
    end
    
    it "should handle a dodgy email" do
      User.new(:email => 'hey diddle diddle').first_name_or_email.should == 'hey diddle diddle'
    end
  end
  
  describe "concatenating the name" do
    before do
      @user = User.new(:first_name => 'Paul', :last_name => 'Campbell')
    end
    
    it "should concatenate the name correctly" do
      @user.full_name.should == "Paul Campbell"
    end

    it "should trim just firstname" do
      @user.last_name = ''
      @user.full_name.should == "Paul"
    end
    
    it "should concatenate the name correctly" do
      @user.first_name = ''
      @user.full_name.should == "Campbell"
    end
  end
end
