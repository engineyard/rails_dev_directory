class CountriesController < ApplicationController
  
  def show
    @providers = Provider.from_country(Country.from_slug(params[:country]).code)
  end
end
