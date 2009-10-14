class Admin::PortfolioItemsController < ApplicationController
  before_filter :admin_required
  layout 'admin'
  
  def new
    @portfolio_item = PortfolioItem.new
    @portfolio_item.provider = Provider.find(params[:provider_id])
  end
  
  def show
    @portfolio_item = PortfolioItem.find(params[:id])
  end
  
  def create
    @portfolio_item = PortfolioItem.new(params[:portfolio_item])
    @portfolio_item.provider = Provider.find(params[:provider_id])
    if @portfolio_item.save
      redirect_to [:admin, @portfolio_item.provider]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @portfolio_item = PortfolioItem.find(params[:id])
  end
  
  def update
    @portfolio_item = PortfolioItem.find(params[:id])
    if @portfolio_item.update_attributes(params[:portfolio_item])
      flash[:notice] = t('portfolio_item.saved_successfully')
      redirect_to [:admin, @portfolio_item.provider]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @portfolio_item = PortfolioItem.find(params[:id])
    @portfolio_item.destroy
    flash[:notice] = t('portfolio_item.deleted_successfully')
    redirect_to [:admin, @portfolio_item.provider]
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_dashboard_path
  end
end