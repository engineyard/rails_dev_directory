class My::DashboardController < ApplicationController
  
  def show
    if logged_in?
      @provider = current_user.provider if logged_in?
    else
      @page = Page.find_by_url('home')
      render 'home/show'
    end
  end
end