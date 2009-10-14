class AddProviderIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :provider_id, :integer
  end

  def self.down
    remove_column :users, :provider_id
  end
end
