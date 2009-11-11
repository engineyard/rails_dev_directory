class My::UsersController < ApplicationController
  
  before_filter :require_user
  
  def edit
    @user = current_user
  end
  
  def update
    if current_user.update_attributes(params[:user].merge({:password_confirmation => params[:user][:password]}))
      flash[:notice] = I18n.t("company_profile.users.saved_successfully", :user => current_user.email)
      redirect_to my_dashboard_path
    else
      render :edit
    end
  end

end