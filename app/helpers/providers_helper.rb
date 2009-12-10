module ProvidersHelper
  def setup_provider(provider)
    returning(provider) do |p|
      p.users.build if p.users.empty?
    end
  end
  
  def setup_services(provider)
    # NOTE: This is a hack to invert the behaviour of :allow_destroy. We want
    # models to persist unless they are unchecked, rather than deleting when
    # they are checked. To achieve this unfortunately we need to re-implement
    # the _delete method which the accepts_nested_attributes_for code hides from
    # us. Ideally rails would be patched to have :allow_destroy => :keep, which
    # would implement this behaviour natively.
    Service.each do |service|
      # NOTE: We have to force loading of the provided services proxy here so
      # that the singleton method we add to the objects is visible to the
      # template code. This is brittle.

      if provided_service = provider.provided_services.detect { |ps| ps.service_id == service.id }
        # If a provided service record exists, then we don't want to delete it,
        # so _delete should return false and the check box should be checked.
        def provided_service._delete
          'false'
        end
      else
        provided_service = provider.provided_services.build(:service_id => service.id)
        # If there isn't an existing record then we assume we don't want to
        # build it unless a prior page submission says we do. The only way to
        # infer this is to dig the information out of params by hand.
        def provided_service._delete
          begin
            params[:provider][:provided_services_attributes].find { |k, v|
              v[:service_id] == self.service_id.to_s
            }[1][:_delete]
          rescue
            'true'
          end
        end
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
            ],
            params[:location]
        )
  end
  
  def availability_select
    select_tag 'availability', options_for_select(
      [
        [t('any'), 'any'],
        ["#{Date.today.strftime("%B")} (#{t('this_month')})",Time.now.to_i],
        [1.month.from_now.strftime("%B"), 1.month.from_now.to_i],
        [2.months.from_now.strftime("%B"), 2.months.from_now.to_i]
        ])
  end
  
  def project_length_select
    select_tag 'weeks', options_for_select(
      [
        ["1-2 #{t('weeks')}", 0],
        ["2-4 #{t('weeks')}", 2],
        ["4-6 #{t('weeks')}", 4],
        [">6 #{t('weeks')}", 6]
        ]
    )    
  end
  
  def hours_per_week_select
    select_tag 'hours', options_for_select(
      [
        ["<10 #{t('hours')}", 0],
        ["10-20 #{t('hours')}", 20],
        ["20-30 #{t('hours')}", 30]
        ]
    )
    
  end
end
