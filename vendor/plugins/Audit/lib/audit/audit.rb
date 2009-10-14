class Audit < ActiveRecord::Base
  belongs_to(:auditable, :polymorphic => true)
  belongs_to :user
  
  named_scope :created, :conditions => {:action => 'create'}
  named_scope :updated, :conditions => {:action => 'update'}
  named_scope :destroyed, :conditions => {:action => 'destroy'}
  
  named_scope :by_object, lambda { |auditable_type| { :conditions => ['auditable_type = ?', auditable_type] } }
end