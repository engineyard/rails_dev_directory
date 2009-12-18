class RfpsController < ApplicationController
  
  before_filter :get_services, :only => [:new, :create]

  def new
    @rfp = Rfp.new(:provider_ids => params[:provider_ids], :budget => params[:budget])
    if params[:provider_id]
      @rfp.providers << Provider.find_by_id(params[:provider_id])
    end
    @providers = @rfp.providers
    if @providers.empty?
      flash[:error] = t('rfp.provider_required')
      redirect_to providers_path
    elsif @providers.size > 3
      flash[:error] = t('rfp.three_provider_max')
      redirect_to providers_path
    end
  end
  
  def show
    @rfp = Rfp.find(params[:id])
  end
  
  def create
    @rfp = Rfp.new(params[:rfp])
    @providers = @rfp.providers
    if verify_recaptcha(:model => @rfp) && @rfp.save
      redirect_to @rfp
    else
      render :new
    end
  end
  
private
  def ssl_allowed?
    true
  end


end