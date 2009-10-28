class Admin::ServicesController < ApplicationController
  
  before_filter :admin_required
  layout 'admin'
  
  def index
    @services = Service.ordered
  end
  
  def new
    @service = Service.new(:position => Service.maximum(:position))
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
end
