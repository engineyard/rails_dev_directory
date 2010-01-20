class Admin::DashboardController < ApplicationController
  
  before_filter :admin_required
  
  layout 'admin'
  def show
    @providers = Provider.find(:all)
    @active_providers = Provider.active.all_by_company_name
    @inactive_providers = Provider.inactive.all_by_company_name
    @flagged_providers = Provider.flagged.all_by_company_name
    @rfps = Rfp.find(:all)
    @endorsements = Endorsement.find(:all)
  end
end
