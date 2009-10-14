class PasswordResetsController < ApplicationController  
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  before_filter :require_no_user
  
  def new
  end
  
  def create
    @user = User.find_by_email(params[:email])  
    if @user  
      @user.deliver_password_reset_instructions!
      flash[:notice] = t('user.password_reset_sent')
      redirect_to root_url  
    else  
      flash[:error] = t('user.not_found')
      render :action => :new  
    end  
  end  
  
  def edit  
    render  
  end

  def update  
    @user.password = params[:user][:password]  
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save  
      flash[:notice] = t('user.password_updated')  
      UserSession.create(@user)
      redirect_to my_dashboard_path
    else  
      render :action => :edit  
    end  
  end  

private  
  def load_user_using_perishable_token  
    @user = User.find_using_perishable_token(params[:id])  
    if !@user  
      flash[:notice] = t('user.account_not_located')
      redirect_to root_url  
    end
  end  
  
  def ssl_required?
    true
  end
end