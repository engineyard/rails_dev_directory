class My::AvailabilityController < ApplicationController
  
  before_filter :require_user
  
  def update
    current_user.provider.update_attributes(params[:provider])
    flash.now[:notice] = t('availability_updated')
    render :show
  end
  
end
