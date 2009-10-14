class Admin::ProvidersController < ApplicationController
  
  before_filter :admin_required
  layout 'admin'
  
  def show
    @provider = Provider.find(params[:id])
  end
  
  def index
    @providers = Provider.all_by_company_name
    respond_to do |wants|
      wants.html
      wants.csv { send_data(Provider.to_csv(:methods => [:owner_name, :owner_email])) }
    end
  end
  
  def new
    @provider = Provider.new
  end
  
  def create
    @provider = Provider.new(params[:provider])
    @provider.aasm_state = params[:provider][:aasm_state]
    if @provider.save
      redirect_to edit_admin_provider_path(@provider)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @provider = Provider.find(params[:id])
  end
  
  def update
    @provider = Provider.find(params[:id])
    @provider.aasm_state = params[:provider][:aasm_state]
    @provider.slug = params[:provider][:slug]
    @provider.user_id = params[:provider][:user_id]
    @provider.recommendations_count = params[:provider][:recommendations_count]
    if @provider.update_attributes(params[:provider])
      flash[:notice] = t('provider.saved_successfully')
      redirect_to [:admin, @provider]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy
    flash[:notice] = t('provider.deleted_successfully')
    redirect_to admin_providers_path
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_providers_path
  end
end