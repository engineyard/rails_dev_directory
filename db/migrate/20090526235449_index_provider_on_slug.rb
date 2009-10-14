class IndexProviderOnSlug < ActiveRecord::Migration
  def self.up
    add_index :providers, :slug
  end

  def self.down
    remove_index :providers, :slug
  end
end