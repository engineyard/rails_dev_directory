class My::AvailabilityController < ApplicationController
  
  before_filter :require_user
  
  def update
    current_user.provider.update_attributes(params[:provider])
    render :show
  end
  
end
