class Service < ActiveRecord::Base
  validates_presence_of :name, :service_category_id
  
  belongs_to :category, :class_name => 'ServiceCategory', :foreign_key => :service_category_id
  
  acts_as_list
  
  named_scope :checked, :conditions => {:checked => true}, :order => "position asc"
  named_scope :ordered, :order => "position asc"
  named_scope :ordered_not_checked, :order => "position asc", :conditions => {:checked => false}
  named_scope :for_category, lambda { |category|
    { :conditions => { :service_category_id => category.id } }
  }
end