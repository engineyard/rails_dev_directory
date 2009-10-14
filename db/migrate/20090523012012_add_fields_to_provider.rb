class AddFieldsToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :hourly_rate, :decimal, :precision => 10, :scale => 2
    add_column :providers, :min_budget, :decimal, :precision => 10, :scale => 2
    add_column :providers, :aasm_state, :string
  end

  def self.down
    remove_column :providers, :aasm_state
    remove_column :providers, :min_budget
    remove_column :providers, :hourly_rate
  end
end