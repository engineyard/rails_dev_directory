module ProvidersHelper
  def setup_provider(provider)
    returning(provider) do |p|
      p.users.build if p.users.empty?
    end
  end
  
  def setup_services(provider)
    Service.each do |service|
      provider.provided_services.build(:service => service) unless provider.provided_services.include?(service)

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
            ],
            params[:location]
        )
  end
  
  def availability_select(model = nil, method = nil, options = {})
    select_options = [
        [t('any_time'), ''],
        ["#{Date.today.strftime("%B")}",Time.now.to_date.beginning_of_month],
        [1.month.from_now.strftime("%B"), 1.month.from_now.to_date.beginning_of_month],
        [2.months.from_now.strftime("%B"), 2.months.from_now.to_date.beginning_of_month]
      ]
    if model and method
      select model, method, select_options, options
    else
      select_tag 'availability', options_for_select( select_options , params[:availability])
    end
  end
  
  def project_length_select(model = nil, method = nil)
    select_options = [
      [t('any'), ''],
      ["1-4 #{t('weeks')}", '0-4'],
      ["4-8 #{t('weeks')}", '4-8'],
      ["#{t('more_than')} 8 #{t('weeks')}", '8-']
      ]
    if model and method
      select model, method, select_options
    else
      select_tag 'weeks', options_for_select(select_options, params[:weeks])
    end   
  end
  
  def hours_per_week_select(model = nil, method = nil)
    select_options = [
      [t('any'), ''],
      ["#{t('less_than')} 15 #{t('hours')}", "0-15"],
      ["15-25 #{t('hours')}", "15-25"],
      ["25-35 #{t('hours')}", "25-35"],
      ["#{t('more_than')} 35 #{t('hours')}", "35-"]
      ]
    if model and method
      select model, method, select_options
    else
      select_tag 'hours', options_for_select(select_options,params[:hours])
    end
  end
end
