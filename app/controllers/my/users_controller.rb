class My::UsersController < ApplicationController
  
  before_filter :require_user
  before_filter :get_user_and_check_permission, :only => [:edit,:update,:destroy]
  
  def index
    @users = current_user.provider.users.paginate(:page => params[:page])
  end

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def show
    @user = User.find(params[:id])
    return permission_denied unless current_user.can_view?(@user)
  end
 
  def create
    @user = User.new(params[:user])
    @user.reset_perishable_token!
    @user.crypted_password = 'nothing'
    @user.provider = current_user.provider
    return permission_denied unless current_user.can_admin?(@user.provider)
    if @user.save
      flash[:notice] = I18n.t('company_profile.users.created_successfully', :user => @user.email)
      redirect_to my_users_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user].merge({:password_confirmation => params[:user][:password]}))
      flash[:notice] = I18n.t("company_profile.users.saved_successfully", :user => @user.email)
      redirect_to my_users_path
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:notice] = I18n.t('company_profile.users.deleted_successfully', :user => @user.email)
    redirect_to my_users_path
  end

private
  def get_user_and_check_permission
    @user = current_user.provider.users.find(params[:id])
    return permission_denied unless current_user.can_edit?(@user)
  end
end