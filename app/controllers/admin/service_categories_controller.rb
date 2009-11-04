class Admin::ServiceCategoriesController < ApplicationController
  
  before_filter :admin_required
  layout 'admin'
  
  def index
    @service_categories = ServiceCategory.ordered
  end
  
  def new
    @service_category = ServiceCategory.new
  end
  
  def create
    @service_category = ServiceCategory.new(params[:service_category])
    if @service_category.save
      redirect_to admin_service_categories_url
    else
      render :new
    end
  end
  
  def edit
    @service_category = ServiceCategory.find(params[:id])
  end
  
  def update
    @service_category = ServiceCategory.find(params[:id])
    if @service_category.update_attributes(params[:service_category])
      redirect_to admin_service_categories_url
    else
      render :edit
    end
  end
  
  def destroy
    @service_category = ServiceCategory.find(params[:id])
    @service_category.destroy
    redirect_to admin_service_categories_url
  end
  
  def sort
    ServiceCategory.order(params[:service_category])
    @service_categories = ServiceCategory.ordered.find(params[:service_category])
    respond_to do |wants|
      wants.js { render :partial => 'service_category', :collection => @service_categories }
    end
  end
  
end
