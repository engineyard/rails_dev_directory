class AddAvatarToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :avatar, :string
  end

  def self.down
    remove_column :providers, :avatar
  end
end
