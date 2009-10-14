class SetUserPasswords < ActiveRecord::Migration
  def self.up
    User.each do |user|
      user.update_attributes(:password => 'password', :password_confirmation => 'password')
    end
  end

  def self.down
  end
end
