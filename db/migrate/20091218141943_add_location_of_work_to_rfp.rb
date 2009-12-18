class AddLocationOfWorkToRfp < ActiveRecord::Migration
  def self.up
    add_column :rfps, :location_of_work, :string
    add_column :rfps, :hours_per_week, :string
  end

  def self.down
    remove_column :rfps, :hours_per_week
    remove_column :rfps, :location_of_work
  end
end
