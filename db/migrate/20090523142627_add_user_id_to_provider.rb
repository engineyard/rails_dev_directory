class AddUserIdToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :user_id, :integer
  end

  def self.down
    remove_column :providers, :user_id
  end
end
