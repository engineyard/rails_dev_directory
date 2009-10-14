class TechnologyType < ActiveRecord::Base
  acts_as_list
  
  named_scope :checked, :conditions => {:checked => true}, :order => "position asc"
  named_scope :ordered, :order => "position asc"
  named_scope :ordered_not_checked, :order => "position asc", :conditions => {:checked => false}
end