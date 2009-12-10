class Admin::SiteConfigsController < ApplicationController
  before_filter :admin_required
  layout 'admin'
end
