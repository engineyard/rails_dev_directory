class AddFullCountryNameToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :full_country_name, :string
  end

  def self.down
    remove_column :providers, :full_country_name
  end
end
