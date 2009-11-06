class HomeController < ApplicationController
  def show
    @homepage = Homepage.first
    @page = Page.find_by_url('home')
    @services = Service.all
  end
end
