class ProvidersController < ApplicationController
  
  ssl_required :new, :create

  def index
    @providers = Provider.active.all_by_company_name.paginate(:page => params[:page])
  end
  
  def by_location
    @providers = Provider.active.all_by_location
  end
  
  def search
    @providers = Provider.search(params)
  end
  
  def show
    @provider = Provider.find(params[:id])
    @provider.increment!(:views) unless logged_in? and current_user.provider == @provider
  end
  
  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(params[:provider])
    @provider.users.first.password = params['provider']['users_attributes']['0']['password']
    @provider.users.first.password_confirmation = params['provider']['users_attributes']['0']['password_confirmation']
    @page_content = Page.find_by_url('provider-signup')
    if verify_recaptcha(:model => @provider) && @provider.save
      UserSession.create(@provider.user)
      Notification.deliver_provider_welcome(@provider.user)
      redirect_to my_dashboard_url
    else
      render :new
    end
  end

end