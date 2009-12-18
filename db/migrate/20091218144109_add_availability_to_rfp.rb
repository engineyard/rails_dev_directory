class AddAvailabilityToRfp < ActiveRecord::Migration
  def self.up
    add_column :rfps, :availability, :string
  end

  def self.down
    remove_column :rfps, :availability
  end
end
