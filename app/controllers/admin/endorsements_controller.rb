class Admin::EndorsementsController < ApplicationController
  before_filter :admin_required
  layout 'admin'

  def index
    if params[:provider_id].not.blank?
      @provider = Provider.find(params[:provider_id])
      @endorsements = @provider.endorsements.paginate(:page => params[:page])
    else
      @endorsements = Endorsement.paginate(:page => params[:page])
    end
  end

  def show
    @endorsement = Endorsement.find(params[:id])
  end

  def destroy
    @endorsement = Endorsement.find(params[:id])
    @endorsement.destroy
    flash[:notice] = t('endorsement.deleted_successfully')
    redirect_to admin_dashboard_url
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_dashboard_path
  end
end
