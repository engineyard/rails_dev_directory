class TopCitiesController < ApplicationController
  
  def index
    @top_cities = TopCity.all(:order => "position")
  end
  
  def show
    @top_city = TopCity.find_by_slug(params[:id])
    @providers = Provider.paginate(:conditions => {
      :city => @top_city.city,
      :state_province => @top_city.state,
      :country => @top_city.country}, :page => params[:page])
    render :template => 'providers/index'
  end
end
