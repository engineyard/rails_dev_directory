class Author < ActiveRecord::Base
  has_many :stories
  acts_as_textiled :blog => :lite_mode
end
