class RemoveProviderIdFromRfp < ActiveRecord::Migration
  def self.up
    remove_column :rfps, :provider_id
  end

  def self.down
    add_column :rfps, :provider_id, :integer
  end
end