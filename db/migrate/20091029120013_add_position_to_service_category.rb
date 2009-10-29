class AddPositionToServiceCategory < ActiveRecord::Migration
  def self.up
    add_column :service_categories, :position, :integer
  end

  def self.down
    remove_column :service_categories, :position
  end
end
