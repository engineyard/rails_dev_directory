class My::ProvidersController < ApplicationController
  
  before_filter :require_user

  def edit
    @provider = current_user.provider
  end
  
  def update
    @provider = current_user.provider
    return permission_denied unless current_user.can_edit?(@provider)
    
    if current_user.can_admin?(@provider)
      @provider.user_id = params[:provider][:user_id]
    end
    
    if @provider.update_attributes(params[:provider])
      flash[:notice] = I18n.t('company_profile.updated_successfully')
      redirect_to @provider
    else
      render :edit
    end
  end

end