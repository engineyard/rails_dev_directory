class My::RecommendationsController < ApplicationController
  
  before_filter :require_user
  
  def index
    @provider = current_user.provider
    @endorsement_requests = @provider.endorsement_requests.all
    @recommendations = @provider.recommendations
  end
  
  def sort
    params[:recommendation].each_with_index do |recommendation_id, index|
      current_user.provider.recommendations.find(recommendation_id).update_attribute(:sort_order, index)
    end
    index
    respond_to do |wants|
      wants.js { render :partial => 'recommendation', :collection => @recommendations }
    end
  end

  def show
    @provider = current_user.provider
    @recommendation = Recommendation.find(params[:id])
  end
  
  def update
    @recommendation = current_user.provider.recommendations.find(params[:id])
    @provider = current_user.provider
    
    @recommendation.aasm_state = params[:state]
    if @recommendation.save
      flash[:notice] = t('recommendation.saved_successfully')
    end
    redirect_to [:my, @recommendation]
  end
  
  def update_all
    @recommendations = current_user.provider.recommendations.find(params[:recommendation_ids])
    @recommendations.each do |recommendation|
      if params[:recommendations][recommendation.id.to_s] and params[:recommendations][recommendation.id.to_s][:approved]
        recommendation.approve!
      else
        recommendation.reject!
      end
    end
    redirect_to my_recommendations_path
  end
end