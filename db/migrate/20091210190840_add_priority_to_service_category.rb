class AddPriorityToServiceCategory < ActiveRecord::Migration
  def self.up
    add_column :services, :priority, :integer
  end

  def self.down
    remove_column :services, :priority
  end
end
