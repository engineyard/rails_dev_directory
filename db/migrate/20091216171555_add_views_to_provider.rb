class AddViewsToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :views, :integer
  end

  def self.down
    remove_column :providers, :views
  end
end
