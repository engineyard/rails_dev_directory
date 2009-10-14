class Admin::RequestsController < ApplicationController
  before_filter :admin_required
  layout 'admin'
  
  def index
    @provider = Provider.find(params[:provider_id])
    @requests = @provider.requests.paginate(:page => params[:page])
  end
end
