class AddSittingIdToResponse < ActiveRecord::Migration
  def self.up
    add_column :responses, :sitting_id, :integer
  end

  def self.down
    remove_column :responses, :sitting_id
  end
end
