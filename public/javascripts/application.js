$(document).ready(function(){
  $('input.confirm').click(function(){
    return confirm(I18n.t('forms.confirm'));
  })
  
  function textarea_maxlength(){
    remaining = $(this).attr('data-count') - $(this).val().length
    console.log(remaining)
    $('.number').html(remaining + '')
    if(remaining >= 0)
    {
        $('.number').removeClass('over-limit')
    }
    else
    {
      $('.number').addClass('over-limit')
    }
  }
  
  $('textarea[data-count]').keyup(textarea_maxlength)
  $('textarea[data-count]').change(textarea_maxlength)
  
  $('input#next').click(function(){
    if($('input[type=checkbox][checked]').length > 3)
    {
      alert(I18n.t('rfp.three_provider_max'))
      return false
    }
  })
  
  $('.date').datepicker()
  
  $('a.tooltip').tooltip({showURL: false})
  
  $('input#country-US, label[for=country-US]').click(function(){
    if($('input#country-US').is(':checked'))
    {
      $('input#country-US').parents('li').find('li input[type=checkbox]').attr('checked', true)
    }
    else
    {
      $('input#country-US').parents('li').find('li input[type=checkbox]').attr('checked', false)
    }
  })
  
  $('ul.location input').each(function(){
    if($(this).attr('id') != 'everywhere')
    {
      $(this).attr('disabled', true)
    }
  })
  
  $('input#everywhere, li.everywhere label').click(function(){
    if($('input#everywhere').is(':checked'))
    {
      $('ul.location input').attr('checked', 'true').attr('disabled', true)
      $('input#everywhere').attr('checked', true).attr('disabled', false)
    }
    else
    {
      $('ul.location input').attr('checked', false).attr('disabled', false)
    }
  })
  
  $('ul.states li input, ul.states li label').click(function(){
    if($('ul.states li input[type=checkbox]:checked').length == 0)
    {
      $('input#country-US').attr('checked', false)
    }
    else
    {
      $('input#country-US').attr('checked', true)
    }
  })
  
  $('a.sort-endorsements').click(function(){
    if($('div#sorting-endorsements').is(':hidden'))
    {
      $('div#sorting-endorsements').show()
      $('div#non-sorting-endorsements').hide()
      $(this).html(I18n.t('provider.done_sorting'))
    }
    else
    {
      $('div#sorting-endorsements').hide()
      $('div#non-sorting-endorsements').show()
      $(this).html(I18n.t('provider.sort_endorsements'))
    }
    return false
  })
  
  $("div#sorting-endorsements ul").sortable({handle:'strong', cursor:'move', update:function(){
      $.post('/my/recommendations/sort', '_method=put&authenticity_token='+AUTH_TOKEN+'&'+$(this).sortable('serialize'), function(data){
        $('#recommendations-collection').html(data)
      })
    }
  })
  
  $('.sortable').sortable({axis:'y', forcePlaceHolderSize: true, update:function(event, ui){
    $.post(ui.item.parents('.sort-list').prev('a.toggle-sort').attr('href'), '_method=put&authenticity_token='+AUTH_TOKEN+'&'+$(this).sortable('serialize'), function(data){
      ui.item.parents('.sort-list').next('.sortable-collection').find('tbody').html(data)
    })
  }})
  
  $('a.toggle-sort').click(function(){
    $(this)
      .next('.sort-list').toggle()
      .next('.sortable-collection').toggle()

    if($(this).html() == I18n.t('general.done_sorting')) {
      $(this).html($(this).data('sort'))
    } else {
      $(this).data('sort', $(this).html())
      $(this).html(I18n.t('general.done_sorting'))
    }
    
    return false
  })
  
  $('input[type="checkbox"].service').map(function() {
    if (!$(this).is(':checked')) {
      $(this).siblings('ul').hide()
    }
    $(this).click(function() {
      if ($(this).is(':checked')) {
        console.log($(this).siblings('ul.testability'))
        $(this).siblings('ul.testability').removeClass('hidden')
      } else {
        $(this).siblings('ul.testability').addClass('hidden')
      }
    })
  })
  
  $('div.day').click(function(){
    checkbox = $(this).find('input')
    if(checkbox.is(':checked'))
    {
      checkbox.attr('checked', false)
      $(this).removeClass('checked')
    }
    else
    {
      checkbox.attr('checked', true)
      $(this).addClass('checked')
    }
    return false
  })
  
  $('a.filter').click(function(){
    parent_element = $(this).parents('h4:first')
    parent_element.toggleClass('active').next('.filters:first').toggleClass('hidden')
    return false
  })
  
  $('a[rel=next]').livequery(function(){
    $(this).click(function(){
      $.getJSON($(this).attr('href').replace('/search', '/search.json'), function(data){
        $('tbody#providers-list').append(data.providers)
        $('#pagination').replaceWith(data.pagination)
      })
      return false
    })
  })
})

var RecaptchaOptions = {
  theme : 'clean'
};