class SessionsController < ApplicationController
  skip_before_filter :require_user # Override application wide filter
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
 
  def new
    @session = UserSession.new
  end
 
  def create
    @session = UserSession.new(params[:user_session])
    if @session.save
      redirect_back_or_default my_dashboard_url
    else
      render :action => :new
    end
  end
 
  def destroy
    current_user_session.destroy
    redirect_back_or_default root_url
  end

private
  def ssl_required?
    true
  end
end
