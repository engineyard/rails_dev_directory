class Service < ActiveRecord::Base
  validates_presence_of :name, :service_category_id
  validates_uniqueness_of :name, :scope => :service_category_id
  
  belongs_to :category, :class_name => 'ServiceCategory', :foreign_key => :service_category_id
  
  acts_as_list :scope => :service_category_id
  
  default_scope :order => 'position asc'
  
  named_scope :checked, :conditions => { :checked => true }
  named_scope :not_checked, :conditions => { :checked => false }
  named_scope :for_category, lambda { |category|
    { :conditions => { :service_category_id => category.id } }
  }
  named_scope :priority, lambda { |priority| { :conditions => {:priority => priority} }}
  named_scope :reject_category, lambda { |category| {:conditions => ["service_category_id != ?", category.id]} if category}
  
  def self.order(ids)
    update_all(
      ['position = FIND_IN_SET(id, ?)', ids.join(',')],
      { :id => ids }
    )
  end
end