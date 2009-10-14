class AddPositionToEndorsement < ActiveRecord::Migration
  def self.up
    add_column :recommendations, :sort_order, :integer
  end

  def self.down
    remove_column :recommendations, :sort_order
  end
end
