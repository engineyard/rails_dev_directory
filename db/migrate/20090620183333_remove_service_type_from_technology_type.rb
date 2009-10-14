class RemoveServiceTypeFromTechnologyType < ActiveRecord::Migration
  def self.up
    remove_column :technology_types, :service_type
  end

  def self.down
    add_column :technology_types, :service_type, :string
  end
end
