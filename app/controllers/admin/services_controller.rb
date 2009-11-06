class Admin::ServicesController < ApplicationController
  
  before_filter :admin_required
  layout 'admin'
  
  def index
    @service_categories = ServiceCategory.all
  end
  
  def new
    @service = Service.new
  end
  
  def create
    @service = Service.new(params[:service])
    if @service.save
      redirect_to admin_services_url
    else
      render :new
    end
  end
  
  def edit
    @service = Service.find(params[:id])
  end
  
  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      redirect_to admin_services_url
    else
      render :edit
    end
  end
  
  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to admin_services_url
  end
  
  def sort
    Service.order(params[:service])
    @services = Service.find(params[:service])
    respond_to do |wants|
      wants.js { render :partial => 'service', :collection => @services }
    end
  end
end
