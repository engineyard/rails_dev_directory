class Admin::TechnologyTypesController < ApplicationController
  
  before_filter :admin_required
  layout 'admin'
  
  def index
    @technology_types = TechnologyType.ordered
  end
  
  def new
    @technology_type = TechnologyType.new(:position => TechnologyType.maximum(:position))
  end
  
  def create
    @technology_type = TechnologyType.new(params[:technology_type])
    if @technology_type.save
      redirect_to admin_technology_types_url
    else
      render :new
    end
  end
  
  def edit
    @technology_type = TechnologyType.find(params[:id])
  end
  
  def update
    @technology_type = TechnologyType.find(params[:id])
    if @technology_type.update_attributes(params[:technology_type])
      redirect_to admin_technology_types_url
    else
      render :edit
    end
  end
  
  def destroy
    @technology_type = TechnologyType.find(params[:id])
    @technology_type.destroy
    redirect_to admin_technology_types_url
  end
end
