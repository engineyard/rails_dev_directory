class CursorPaginationRenderer < WillPaginate::LinkRenderer
  
  def to_html
    if @collection.next_page
      out = page_link_or_span(@collection.next_page, 'ajax-pagination', I18n.t('show_more_results'))
    else
      out = I18n.t('no_more_results')
    end
    @template.content_tag('div',
      out,
      :class => 'aligncenter', :id => 'pagination')
  end
  
end