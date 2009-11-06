module RfpsHelper
  def setup_rfp(rfp)
    Service.all.reject { |t| rfp.requested_services.collect{ |s| s.name }.include?(t.name) }.each do |service|
      rfp.requested_services.build(:name => service.name, :checked => (params[:service_ids] && params[:service_ids].include?(service.id.to_s)) || service.checked?)
    end
    return rfp
  end
end