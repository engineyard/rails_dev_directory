class Admin::TopCitiesController < ApplicationController
  inherit_resources
  
  def create
    create! { admin_top_cities_path }
  end
                               
  def update                   
    update! { admin_top_cities_path }
  end
end
