class AddNoindexNofollowToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :noindex, :boolean
    add_column :pages, :nofollow, :boolean
    add_column :pages, :canonical, :string
    add_column :pages, :enable_canonical, :boolean
    add_column :pages, :enable_keywords, :boolean
  end

  def self.down
    remove_column :pages, :enable_canonical
    remove_column :pages, :enable_keywords
    remove_column :pages, :canonical
    remove_column :pages, :nofollow
    remove_column :pages, :noindex
  end
end
