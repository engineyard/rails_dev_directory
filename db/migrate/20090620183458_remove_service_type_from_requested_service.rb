class RemoveServiceTypeFromRequestedService < ActiveRecord::Migration
  def self.up
    remove_column :requested_services, :service_type
  end

  def self.down
    add_column :requested_services, :service_type, :string
  end
end
