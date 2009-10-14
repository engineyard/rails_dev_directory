class My::PortfolioItemsController < ApplicationController

  before_filter :require_user

  def index
    @portfolio_items = current_user.provider.portfolio_items
  end

  def show
    @portfolio_item = PortfolioItem.find(params[:id])
  end

  def edit
    @portfolio_item = PortfolioItem.find(params[:id])
    return permission_denied unless current_user.can_edit?(@portfolio_item.provider)
  end

  def update
    @portfolio_item = PortfolioItem.find(params[:id])
    return permission_denied unless current_user.can_edit?(@portfolio_item.provider)

    if @portfolio_item.update_attributes(params[:portfolio_item])
      flash[:notice] = I18n.t("portfolio_item.saved_successfully")
      redirect_to my_portfolio_items_path
    else
      render :edit
    end
  end

  def new
    @portfolio_item = PortfolioItem.new(:provider => current_user.provider)
    if @portfolio_item.provider.has_enough_portfolio_items?
      flash[:error] = I18n.t('portfolio_item.validations.too_many')
      redirect_to my_portfolio_items_path
    end
  end

  def create
    @portfolio_item = PortfolioItem.new(params[:portfolio_item])
    @portfolio_item.provider = current_user.provider
    
    if @portfolio_item.save
      flash[:notice] = I18n.t('portfolio_item.saved_successfully')
      redirect_to my_portfolio_items_path
    else
      render :new
    end
  end

  def destroy
    @portfolio_item = PortfolioItem.find(params[:id])
    return permission_denied unless current_user.can_edit?(@portfolio_item.provider)

    @portfolio_item.destroy
    flash[:notice] = t('portfolio_item.deleted_successfully')
    redirect_to my_portfolio_items_path
  rescue ActiveRecord::RecordNotFound
    redirect_to my_portfolio_items_path
  end
end
