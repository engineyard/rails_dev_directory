class My::RequestsController < ApplicationController

  before_filter :require_user
  
  def index
    @requests = current_user.provider.requests.paginate(:page => params[:page])
  end
  
  def show
    @request = Request.find(params[:id])
    @request.update_attribute(:unread, false) if @request.unread?
    @rfp = @request.rfp
    return permission_denied unless current_user.can_view?(@request)
  end
  
  def destroy
    @request = Request.find(params[:id])
    return permission_denied unless current_user.can_edit?(@request.provider)
    
    @request.destroy

    redirect_to my_requests_path
  end
end
