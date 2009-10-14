class AddPostCodeToRfp < ActiveRecord::Migration
  def self.up
    add_column :rfps, :postal_code, :string
  end

  def self.down
    remove_column :rfps, :postal_code
  end
end
