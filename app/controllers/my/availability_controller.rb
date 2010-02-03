class My::AvailabilityController < ApplicationController
  
  before_filter :require_user
  
  def update
    current_user.provider.update_attributes(params[:provider])
    flash.now[:notice] = t('availability_updated')
    if current_user.provider.active?
      render :show
    else
      redirect_to my_dashboard_path
    end
  end
  
end
