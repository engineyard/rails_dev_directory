class AddMinAndMaxHoursToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :min_hours, :integer
    add_column :providers, :max_hours, :integer
  end

  def self.down
    remove_column :providers, :max_hours
    remove_column :providers, :min_hours
  end
end
