class AddProficiencyToProvidedServices < ActiveRecord::Migration
  def self.up
    add_column :provided_services, :proficiency, :integer
  end

  def self.down
    remove_column :provided_services, :proficiency
  end
end
