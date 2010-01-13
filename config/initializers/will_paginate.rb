class ActiveRecord::Base
  def self.per_page
    20
  end
end

WillPaginate::ViewHelpers.pagination_options[:renderer] = 'CursorPaginationRenderer'