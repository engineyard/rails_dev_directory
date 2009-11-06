class ReferenceRequestsController < ApplicationController

  def new
    @reference_request = ReferenceRequest.new(:endorsement_id => params[:endorsement_id])
  end
  
  def create
    @reference_request = ReferenceRequest.new(params[:reference_request])
    if @reference_request.save
      flash[:notice] = t('reference_request.thanks', :name => @reference_request.endorsement.name)
      redirect_to @reference_request.endorsement.provider
    else
      render :new
    end
  end

end
