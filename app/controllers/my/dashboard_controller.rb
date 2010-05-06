class My::DashboardController < ApplicationController
  
  def show
    if logged_in?
      @provider = current_user.provider if logged_in?
    else
      @page_url = 'home'
      @page = Page.find_by_url(@page_url)
      @page_content = @page
      render 'home/show'
    end
  end
end