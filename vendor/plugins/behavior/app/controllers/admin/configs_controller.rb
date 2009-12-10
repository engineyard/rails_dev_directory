class Admin::ConfigsController < ApplicationController
  
  layout Behavior::Settings.layout
  Behavior::Settings.before_filters.each do |filter|
    before_filter filter
  end
  
  def show
    @configs = config.all
  end
  
  def update
    config.all.each do |conf|
      config.update(params[:conf])
    end
    flash[:notice] = "Config Changes Saved"
    redirect_to admin_config_path
  end
  
end