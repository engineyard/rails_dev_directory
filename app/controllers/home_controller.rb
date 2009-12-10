class HomeController < ApplicationController
  def show
    @homepage = Homepage.first
    @page = Page.find_by_url('home')
    @general_category = ServiceCategory.find_by_name('General')
    @general_services = @general_category ? @general_category.services : []
    @top_services = Service.priority(1).reject_category(@general_category)
    @mid_services = Service.priority(2).reject_category(@general_category)
    @bottom_services = Service.priority(3).reject_category(@general_category)
  end
end
