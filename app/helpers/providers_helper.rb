module ProvidersHelper
  def setup_provider(provider)
    returning(provider) do |p|
      p.users.build if p.users.empty?
    end
  end
  
  def company_size(provider)
    mapping = {}
    Provider.options_for_company_size.each do |item|
      mapping[item.second] = item.first
    end
    return mapping[provider.company_size]
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
