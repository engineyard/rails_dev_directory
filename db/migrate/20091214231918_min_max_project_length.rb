class MinMaxProjectLength < ActiveRecord::Migration
  def self.up
    rename_column :providers, :project_length, :min_project_length
    add_column :providers, :max_project_length, :integer
  end

  def self.down
    remove_column :providers, :max_project_length
    rename_column :providers, :min_project_length
  end
end
