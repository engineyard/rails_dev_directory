class SetDefaultOfZeroOnMinBudget < ActiveRecord::Migration
  def self.up
    change_column :providers, :min_budget, :decimal, :precision => 10, :scale => 2, :default => 0
  end

  def self.down
    change_column :providers, :min_budget, :decimal, :precision => 10, :scale => 2
  end
end
