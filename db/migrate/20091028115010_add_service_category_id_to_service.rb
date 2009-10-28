class AddServiceCategoryIdToService < ActiveRecord::Migration
  def self.up
    add_column :services, :service_category_id, :integer
    add_index :services, :service_category_id
  end

  def self.down
    remove_index :services, :service_category_id
    remove_column :services, :service_category_id
  end
end
