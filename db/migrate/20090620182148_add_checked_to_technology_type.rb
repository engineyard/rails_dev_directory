class AddCheckedToTechnologyType < ActiveRecord::Migration
  def self.up
    add_column :technology_types, :checked, :boolean
  end

  def self.down
    remove_column :technology_types, :checked
  end
end
