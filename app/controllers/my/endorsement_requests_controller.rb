class My::EndorsementRequestsController < ApplicationController
  
  before_filter :require_user
  
  def new
    @endorsement_request = EndorsementRequest.new
  end

  def create
    @endorsement_request = EndorsementRequest.new(params[:endorsement_request])
    @endorsement_request.provider = current_user.provider
    if @endorsement_request.save
      flash[:notice] = I18n.t('endorsement_request.submission.thanks_for_requesting') + @endorsement_request.emails.to_sentence
      redirect_to my_dashboard_path
    else
      render :new
    end
  end

end