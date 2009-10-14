require File.dirname(__FILE__) + '/spec_helper'

class TestModel < ActiveRecord::Base
  audit

  def self.table_name
    'boojas'
  end
end

class TestOtherModel < ActiveRecord::Base
  audit

  def self.table_name
    'boojas'
  end
end

class User
end

describe Audit do
  before(:each) do
    User.stub!(:current_user).and_return(mock_model(User, :id => 42))
    Audit.destroy_all
    @test_model = TestModel.new
    @test_other_model = TestOtherModel.new
  end
  
  it "should use named scope model to model" do
    @test_model.save!
    @test_other_model.save!
    TestModel.created.count.should == 1
  end
  
  it "should create a create audit on create" do
    @test_model.save!
    @test_model.audits.count.should == 1
    @test_model.audits.first.action.should == 'create'
    @test_model.audits.first.user_id.should == 42
    @test_model.audits.first.auditable.should == @test_model
    @test_model.audits.created.size.should == 1
    TestModel.created.size.should == 1
    TestModel.created.count.should == 1
  end
  
  it "should create an update audit on update" do
    @test_model.save!
    @test_model.shortcode_url = 'hey'
    @test_model.save!
    @test_model.audits.count.should == 2
    @test_model.audits.last.action.should == 'update'
    @test_model.audits.last.user_id.should == 42
    @test_model.audits.last.auditable.should == @test_model
    @test_model.audits.created.size.should == 1
    @test_model.audits.updated.size.should == 1
    TestModel.updated.size.should == 1
    TestModel.updated.count.should == 1
  end
  
  it "should create a delete audit on delete" do
    @test_model.save!
    @test_model.destroy
    @test_model.audits.count.should == 2
    @test_model.audits.last.action.should == 'destroy'
    @test_model.audits.last.user_id.should == 42
    @test_model.audits.last.auditable_id.should == @test_model.id
    @test_model.audits.created.size.should == 1
    TestModel.destroyed.size.should == 1
    TestModel.destroyed.count.should == 1
  end
end