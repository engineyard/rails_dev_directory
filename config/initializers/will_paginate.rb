class ActiveRecord::Base
  def self.per_page
    50
  end
end

WillPaginate::ViewHelpers.pagination_options[:renderer] = 'CursorPaginationRenderer'