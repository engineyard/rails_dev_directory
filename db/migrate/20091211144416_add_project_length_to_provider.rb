class AddProjectLengthToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :project_length, :integer
  end

  def self.down
    remove_column :providers, :project_length
  end
end
