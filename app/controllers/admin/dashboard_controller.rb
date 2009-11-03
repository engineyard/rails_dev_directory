class Admin::DashboardController < ApplicationController
  
  before_filter :admin_required
  
  layout 'admin'
  def show
    @providers = Provider.find(:all)
    @active_providers = Provider.active.find(:all)
    @inactive_providers = Provider.inactive.find(:all)
    @flagged_providers = Provider.flagged.find(:all)
    @rfps = Rfp.find(:all)
    @endorsements = Endorsement.find(:all)
  end
end
