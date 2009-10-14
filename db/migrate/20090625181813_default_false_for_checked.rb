class DefaultFalseForChecked < ActiveRecord::Migration
  def self.up
    change_column :technology_types, :checked, :boolean, :null => false, :default => false
  end

  def self.down
    change_column :technology_types, :checked, :boolean
  end
end
