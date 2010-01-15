class Booking < ActiveRecord::Base
  
  validates_uniqueness_of :date, :scope => :provider_id
  
  named_scope :upcoming, :conditions => "date >= #{Date.today}"
  
  def select=(value)
    @select = value
  end
  
  def select
    @select ||= true unless new_record?
  end
end
