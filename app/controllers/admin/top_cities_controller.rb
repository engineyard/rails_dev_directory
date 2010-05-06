class Admin::TopCitiesController < ApplicationController
  inherit_resources
  before_filter :admin_required
  layout 'admin'
  
  def sort
    TopCity.order(params[:top_city])
    index! do |wants|
      wants.js { render :partial => 'top_city', :collection => @top_cities }
    end
  end
  
  def create
    create! { admin_top_cities_path }
  end
                               
  def update                   
    update! { admin_top_cities_path }
  end
  
protected
  def collection
    @top_cities ||= end_of_association_chain.all(:order => 'position')
  end
end
