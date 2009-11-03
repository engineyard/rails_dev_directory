class Admin::RecommendationsController < ApplicationController
  before_filter :admin_required
  layout 'admin'

  def index
    if params[:provider_id].not.blank?
      @provider = Provider.find(params[:provider_id])
      @recommendations = @provider.recommendations.paginate(:page => params[:page])
    else
      @recommendations = Recommendation.paginate(:page => params[:page])
    end
  end

  def show
    @recommendation = Recommendation.find(params[:id])
  end

  def destroy
    @recommendation = Recommendation.find(params[:id])
    @recommendation.destroy
    flash[:notice] = t('recommendation.deleted_successfully')
    redirect_to admin_dashboard_url
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_dashboard_path
  end
end
