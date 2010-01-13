class Admin::UsersController < ApplicationController
  
  ssl_required
  
  before_filter :admin_required
  layout 'admin'

  def index
    @users = User.all(:order => 'admin desc')
  end
  
  def new
    @user = User.new
    @user.provider = Provider.find_by_id(params[:provider_id])
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    @user.provider_id = params[:user][:provider_id]
    @user.password = params[:user][:password]
    @user.password_confirmation = @user.password
    @user.reset_perishable_token!
    if @user.save
      redirect_to [:admin, @user]
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def change_password
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user].merge({:password_confirmation => params[:user][:password]}))
      @user.admin = params[:user][:admin] unless current_user == @user
      @user.provider = Provider.find_by_id(params[:user][:provider_id])
      @user.save!
      flash[:notice] = t('user.saved_successfully')
      redirect_to [:admin, @user]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = t('user.deleted_successfully')
    redirect_to [:admin, @user.provider]
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_dashboard_path
  end
  
  def take_control
    @user = User.find(params[:id])
    UserSession.create(@user)
    redirect_to my_dashboard_url
  end


  def resend_welcome
    @user = User.find(params[:id])
    @user.send_welcome(params[:subject], params[:message])
    flash[:notice] = t('user.welcome_message_sent')
    redirect_to [:admin, @user.provider]
  end
  
end
