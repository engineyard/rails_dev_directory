class ReferencesController < ApplicationController

  before_filter :find_reference_request
  before_filter :validate_reference_request

  def new
    @reference = @reference_request.build_reference
  end
  
  def create
    @reference = Reference.new(params[:reference])
    if @reference.save
      flash[:notice] = I18n.t('reference.thanks')
      redirect_to @reference_request.endorsement.provider
    else
      render :new
    end
  end
  
  private
  
  def find_reference_request
    @reference_request = ReferenceRequest.find_by_validation_token(params[:key])
  end

  def validate_reference_request
    unless @reference_request and @reference_request.endorsement.provider.slug == params[:provider_id]
      redirect_to provider_path(params[:provider_id])
    end
    if @reference_request.reference.not.nil?
      flash[:error] = I18n.t('reference.already_responded')
      redirect_to provider_path(params[:provider_id])
    end
  end

end
