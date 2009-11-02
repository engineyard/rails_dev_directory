class RecommendationsController < ApplicationController
  
  before_filter :find_provider
  before_filter :validate_recipient, :only => [:new, :create]
  
  def index
    @recommendations = @provider.recommendations.approved.paginate(:page => params[:page])
  end

  def new
    @recommendation = Recommendation.new(:provider => @provider)
  end
  
  def create
    @recommendation = Recommendation.new(params[:recommendation])
    @recommendation.provider = @provider
    
    if verify_recaptcha(:model => @recommendation) && @recommendation.save
      flash[:notice] = I18n.t('recommendation.thanks')
      redirect_to @provider
    else
      render :new
    end
  end
  
  private
  
  def find_provider
    @provider = Provider.find(params[:provider_id])
  end
  
  def validate_recipient
    @recipient = EndorsementRequestRecipient.find_by_validation_token(params[:key])
    unless @recipient and @recipient.endorsement_request.provider.slug == params[:provider_id]
      flash[:error] = I18n.t('recommendation.validations.use_the_key')
      redirect_to @provider
    end
  end
  
end
