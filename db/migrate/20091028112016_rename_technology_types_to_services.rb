class RenameTechnologyTypesToServices < ActiveRecord::Migration
  def self.up
    rename_table :technology_types, :services
    rename_column :provided_services, :technology_type_id, :service_id
  end

  def self.down
    rename_column :provided_services, :service_id, :technology_type_id
    rename_table :services, :technology_types
  end
end
