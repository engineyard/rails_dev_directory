{"city"=>"Barcelona", "postal_code"=>"08903", "state_province"=>"NA", "further_street_address"=>"", "company_url"=>"http://www.hashref.com", "company_name"=>"", "country"=>"ES", "phone_number"=>"+34 616 44 49 48", "terms_of_service"=>"1", "street_address"=>"Travesser de les Corts, 48, Sobreatic 2a", "users_attributes"=>{"0"=>{"password_confirmation"=>"xavier", "first_name"=>"Xavier", "password"=>"xavier", "last_name"=>"Noria", "email"=>"fxn@hashref.com"}}}

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include SslRequirement
  
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
  
  def get_services
    @general_category = ServiceCategory.find_by_name(config[:general_service])
    @general_services = @general_category ? @general_category.services : []
    @top_services = Service.priority(1).reject_category(@general_category)
    @mid_services = Service.priority(2).reject_category(@general_category)
    @bottom_services = Service.priority(3).reject_category(@general_category)
  end
end
