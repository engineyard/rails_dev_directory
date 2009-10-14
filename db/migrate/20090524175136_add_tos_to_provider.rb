class AddTosToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :tos, :boolean
  end

  def self.down
    remove_column :providers, :tos
  end
end
