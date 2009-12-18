module RfpsHelper
  def setup_rfp(rfp)
    Service.all.reject { |t| rfp.requested_services.collect{ |s| s.name }.include?(t.name) }.each do |service|
      rfp.requested_services.build(:name => service.name, :checked => (params[:service_ids] && params[:service_ids].include?(service.id.to_s)) || service.checked?)
    end
    return rfp
  end
  
  def rfp_hours(amount)
    min, max = amount.to_s.split('-')
    return "#{min}-#{max} #{t("hours")}" if min.not.blank? and max.not.blank?
    return "#{t('less_than')} #{max} #{t('hours')}" if max and min.blank?
    return "#{t('more_than')} #{min} #{t('hours')}" if min and max.blank?
  end
  
  def rfp_duration(amount)
    min, max = amount.to_s.split('-')
    return "#{min}-#{max} #{t("weeks")}" if min.not.blank? and max.not.blank?
    return "#{t('less_than')} #{max} #{t('weeks')}" if max and min.blank?
    return "#{t('more_than')} #{min} #{t('week')}" if min.to_i == 1 and max.blank?
    return "#{t('more_than')} #{min} #{t('weeks')}" if min and max.blank?
  end
end