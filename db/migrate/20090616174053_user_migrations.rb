class UserMigrations < ActiveRecord::Migration
  def self.up
    remove_column :users, :login
    remove_column :users, :crypted_password
    remove_column :users, :name
    remove_column :users, :remember_token
    remove_column :users, :remember_token_expires_at
    remove_column :users, :salt
    
      # t.string :login, :null => false
      # t.string :crypted_password, :null => false
      # t.string :password_salt, :null => false
      # t.string :persistence_token, :null => false
      # t.integer :login_count, :default => 0, :null => false
      # t.datetime :last_request_at
      # t.datetime :last_login_at
      # t.datetime :current_login_at
      # t.string :last_login_ip
      # t.string :current_login_ip
    add_column :users, :crypted_password, :string, :null => false
    add_column :users, :password_salt, :string, :null => false
    add_column :users, :persistence_token, :string, :null => false
    add_column :users, :login_count, :integer, :default => 0, :null => false
    add_column :users, :last_request_at, :datetime
    add_column :users, :last_login_at, :datetime
    add_column :users, :current_login_at, :datetime
    add_column :users, :last_login_ip, :string
    add_column :users, :current_login_ip, :string
  end

  def self.down
    remove_column :users, :current_login_ip
    remove_column :users, :last_login_ip
    remove_column :users, :current_login_at
    remove_column :users, :last_login_at
    remove_column :users, :last_request_at
    remove_column :users, :login_count
    remove_column :users, :persistence_token
    remove_column :users, :password_salt
    remove_column :users, :crypted_password
    add_column :users, :salt, :string,                      :limit => 40
    add_column :users, :remember_token_expires_at, :datetime
    add_column :users, :remember_token, :string,            :limit => 40
    add_column :users, :name, :string
    add_column :users, :crypted_password, :string,          :limit => 40
    add_column :users, :login, :string,                     :limit => 40
  end
end
