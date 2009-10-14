class AddShortcodeUrlToRfp < ActiveRecord::Migration
  def self.up
    add_column :rfps, :shortcode_url, :string
  end

  def self.down
    remove_column :rfps, :shortcode_url
  end
end
