class ServiceCategory < ActiveRecord::Base
  validates_presence_of :name
  
  def self.options_for_select
    all(:order => :name).collect { |sc| [sc.name, sc.id] }
  end
end
