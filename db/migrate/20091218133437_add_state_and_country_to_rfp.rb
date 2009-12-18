class AddStateAndCountryToRfp < ActiveRecord::Migration
  def self.up
    add_column :rfps, :state, :string
    add_column :rfps, :country, :string
  end

  def self.down
    remove_column :rfps, :country
    remove_column :rfps, :state
  end
end
