module ProvidersHelper
  def setup_provider(provider)
    returning(provider) do |p|
      p.users.build if p.users.empty?
    end
  end
  
  def setup_services(provider)
    service_ids = provider.provided_services.map(&:service_id)
    Service.each do |service|
      unless service_ids.include?(service.id)
        provider.provided_services.build(:service_id => service.id)
      end
    end
  end
  
  def price(number)
    return '-' if number.blank? or number == 0
    precision = number.to_i == number ? 0 : 2
    return number_to_currency(number, :precision => precision) if number.not.blank?
  end
  
  def location_select
    select_tag 'location', options_for_select([[t('provider.all_locations'), ""]]) +  
      grouped_options_for_select(
        [
          ["USA", Provider.us_based.by_state.collect do |p|
            [State.by_code(p.state_province), "US-#{p.state_province}"]
            end],
          [t('provider.international'), Provider.locations_for_select]
            ]
        )
  end
end
