class AddSlugToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :slug, :string
  end

  def self.down
    remove_column :providers, :slug
  end
end
