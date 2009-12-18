class HomeController < ApplicationController
  
  before_filter :get_services
  
  def show
    @homepage = Homepage.first
    @page = Page.find_by_url('home')
  end
end
