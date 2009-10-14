class AddFurtherStreetAddressToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :further_street_address, :string
  end

  def self.down
    remove_column :providers, :further_street_address
  end
end
