module RfpsHelper
  def setup_rfp(rfp)
    TechnologyType.ordered.reject { |t| rfp.requested_services.collect{ |s| s.name }.include?(t.name) }.each do |technology_type|
      rfp.requested_services.build(:name => technology_type.name, :checked => (params[:technology_type_ids] && params[:technology_type_ids].include?(technology_type.id.to_s)) || technology_type.checked?)
    end
    return rfp
  end
end