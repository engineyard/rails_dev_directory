class My::EndorsementsController < ApplicationController
  
  before_filter :require_user
  
  def index
    @provider = current_user.provider
    @endorsement_requests = @provider.endorsement_requests.all
    @endorsements = @provider.endorsements
  end
  
  def sort
    params[:endorsement].each_with_index do |endorsement_id, index|
      current_user.provider.endorsements.find(endorsement_id).update_attribute(:sort_order, index)
    end
    index
    respond_to do |wants|
      wants.js { render :partial => 'endorsement', :collection => @endorsements }
    end
  end

  def show
    @provider = current_user.provider
    @endorsement = Endorsement.find(params[:id])
  end
  
  def update
    @endorsement = current_user.provider.endorsements.find(params[:id])
    @provider = current_user.provider
    
    @endorsement.aasm_state = params[:state]
    if @endorsement.save
      flash[:notice] = t('endorsement.saved_successfully')
    end
    redirect_to [:my, @endorsement]
  end
  
  def update_all
    @endorsements = current_user.provider.endorsements.find(params[:endorsement_ids])
    @endorsements.each do |endorsement|
      if params[:endorsements][endorsement.id.to_s] and params[:endorsements][endorsement.id.to_s][:approved]
        endorsement.approve!
      else
        endorsement.reject!
      end
    end
    redirect_to my_endorsements_path
  end
end