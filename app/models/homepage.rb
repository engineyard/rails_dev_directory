class Homepage < ActiveRecord::Base
  acts_as_textiled :content
  xss_terminate :except => [:content]
end
