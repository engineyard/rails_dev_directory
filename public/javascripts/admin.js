$(function(){
	$('.sortable').sortable({axis:'y', containment: 'parent', forcePlaceHolderSize: true, update:function(){
    $.post($('a.sort:first').attr('href'), '_method=put&authenticity_token='+AUTH_TOKEN+'&'+$(this).sortable('serialize'), function(data){
      $('.sorted-list').html(data)
    })
  }})

	$('a.sort').click(function(){
		if($('.sortable').is(':hidden'))
		{
			$('.sortable').show()
			$('.sorted').hide()
			$(this).html(I18n.t('general.done_sorting'))
		}
		else
		{
			$('.sortable').hide()
			$('.sorted').show()
			$(this).html(I18n.t('general.sort_list'))
		}
		return false
	})
})