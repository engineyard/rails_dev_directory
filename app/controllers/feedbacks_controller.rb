class FeedbacksController < ApplicationController

  def new
    @provider = Provider.find(params[:provider_id])
    @feedback = @provider.feedbacks.build
  end

  def create
    @provider = Provider.find(params[:provider_id])
    @feedback = @provider.feedbacks.build(params[:feedback])

    if @feedback.save
      flash[:notice] = t('feedback.saved_succesfully', :company => @feedback.provider.company_name)
      redirect_to @feedback.provider
    else
      @provider = @feedback.provider
      render :new
    end
  end

end
