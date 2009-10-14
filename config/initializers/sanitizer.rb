ActionView::Base.sanitized_allowed_attributes = 'id', 'class', 'style', 'src'
ActionView::Base.sanitized_allowed_tags = 'table', 'tr', 'td', 'img', 'br', 'object', 'param', 'embed', 'p', 'em', 'strong', 'h1', 'h2', 'h3', 'h4', 'h5', 'ul', 'li'

ActionView::Base.sanitized_allowed_tags.delete 'a'