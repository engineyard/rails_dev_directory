class Admin::RfpsController < ApplicationController
  
  before_filter :admin_required
  layout 'admin'
  
  def index
    @rfps = Rfp.paginate(:page => params[:page])
    respond_to do |wants|
      wants.html
      wants.csv { send_data(Rfp.to_csv) }
    end
  end
  
  def show
    @rfp = Rfp.find(params[:id])
  end
  
  def destroy
    @rfp = Rfp.find(params[:id])
    @rfp.destroy
    flash[:notice] = t('rfp.deleted_successfully')
    redirect_to admin_dashboard_url
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_dashboard_path
  end
end
