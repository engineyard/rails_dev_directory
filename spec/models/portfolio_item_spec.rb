require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PortfolioItem do
  before do
    @provider = Factory.create(:provider)
  end

  it "should not be valid if it is the fourth item for a provider" do
    @provider.portfolio_items << @portfolio_item = Factory.build(:portfolio_item, :provider => @provider)
    @portfolio_item.should be_valid
    @provider.portfolio_items << @portfolio_item = Factory.build(:portfolio_item, :provider => @provider)
    @portfolio_item.should be_valid
    @provider.portfolio_items << @portfolio_item = Factory.build(:portfolio_item, :provider => @provider)
    @portfolio_item.should be_valid
    @provider.portfolio_items << @portfolio_item = Factory.build(:portfolio_item, :provider => @provider)
    @portfolio_item.should_not be_valid
  end
end
