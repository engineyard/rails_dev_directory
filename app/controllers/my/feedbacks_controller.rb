class My::FeedbacksController < ApplicationController

  before_filter :require_user
  before_filter :find_feedback
  
  def edit
  end
  
  def update
    if params[:accept] == 'yes'
      flash[:notice] = t('feedback.accepted')
      @feedback.accept!
    else
      flash[:notice] = t('feedback.rejected')
      @feedback.reject!
    end

    redirect_to current_user.provider
  end

  private
  
  def find_feedback
    begin
      @feedback = current_user.provider.feedbacks.unaccepted.find(params[:id])
    rescue
      redirect_to current_user.provider
    end
  end

end
