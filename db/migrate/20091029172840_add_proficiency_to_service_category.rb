class AddProficiencyToServiceCategory < ActiveRecord::Migration
  def self.up
    add_column :service_categories, :proficiency, :boolean
  end

  def self.down
    remove_column :service_categories, :proficiency
  end
end
