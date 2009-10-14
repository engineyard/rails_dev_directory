class AddUnreadToRequest < ActiveRecord::Migration
  def self.up
    add_column :requests, :unread, :boolean, :default => true
  end

  def self.down
    remove_column :requests, :unread
  end
end
