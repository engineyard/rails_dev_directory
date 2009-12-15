class RemoveCorrectFromAnswer < ActiveRecord::Migration
  def self.up
    remove_column :answers, :correct
  end

  def self.down
    add_column :answers, :correct, :boolean
  end
end
