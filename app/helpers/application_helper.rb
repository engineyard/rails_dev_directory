# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def yes_or_no(status)
    return I18n.t('general.yes') if status
    return I18n.t('general.no')
  end
  
  def display_flash
    return %Q[<div class="notice">#{h(flash[:notice])}</div>] if flash[:notice]
    return %Q[<div class="error">#{h(flash[:error])}</div>] if flash[:error]
    return %Q[<div class="warning">#{h(flash[:warning])}</div>] if flash[:warning]
  end
end
