class Admin::PagesController < ApplicationController
  before_filter :admin_required
  layout 'admin'
  
  def index
    @pages = Page.all(:order => 'title asc')
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    @page.url = params[:page][:url]
    if @page.save
      flash[:notice] = t('page.saved_successfully')
      redirect_to admin_pages_path
    else
      render :new
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = t('page.saved_successfully')
      redirect_to admin_pages_path
    else
      render :edit
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = t('page.deleted_successfully')
    redirect_to admin_pages_path
  end

end
