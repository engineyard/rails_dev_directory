# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include SslRequirement
  include ExceptionNotifiable
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :number
  
  before_filter :get_page_content
  
  def permission_denied
    respond_to do |format|
      format.html {
        flash[:error] = I18n.t('general.access_denied')
        redirect_to root_path
        }
      format.xml { render :xml => I18n.t('general.access_denied') }
    end
    return false
  end
  
protected
  def admin_required
    return access_denied unless logged_in? and current_user.admin?
  end
  
  def get_page_content
    @page_content = Page.find_by_url("#{controller_name}/#{action_name}")
  end

private

  def ssl_allowed?
    true
  end

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  helper_method :current_user
  
  def access_denied
    store_location
    redirect_to login_path
    return false
  end
  
  def require_user
    unless current_user
      access_denied
    end
  end

  def require_no_user
    if current_user
      store_location
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
