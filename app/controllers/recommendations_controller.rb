class RecommendationsController < ApplicationController
  
  def index
    @provider = Provider.find(params[:provider_id])
    @recommendations = @provider.recommendations.approved.paginate(:page => params[:page])
  end

  def new
    @provider = Provider.find(params[:provider_id])
    @recommendation = Recommendation.new(:provider => @provider)
  end
  
  def create
    @provider = Provider.find(params[:provider_id])
    @recommendation = Recommendation.new(params[:recommendation])
    @recommendation.provider = @provider
    
    if verify_recaptcha(:model => @recommendation) && @recommendation.save
      flash[:notice] = I18n.t('recommendation.thanks')
      redirect_to @provider
    else
      render :new
    end
  end
end
