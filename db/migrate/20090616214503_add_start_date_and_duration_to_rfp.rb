class AddStartDateAndDurationToRfp < ActiveRecord::Migration
  def self.up
    add_column :rfps, :start_date, :date
    add_column :rfps, :duration, :string
  end

  def self.down
    remove_column :rfps, :duration
    remove_column :rfps, :start_date
  end
end
