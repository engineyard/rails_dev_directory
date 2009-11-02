class AddStateToTopCity < ActiveRecord::Migration
  def self.up
    add_column :top_cities, :state, :string
    add_column :top_cities, :slug, :string
    add_index :top_cities, :slug
  end

  def self.down
    remove_index :top_cities, :slug
    remove_column :top_cities, :slug
    remove_column :top_cities, :state
  end
end
