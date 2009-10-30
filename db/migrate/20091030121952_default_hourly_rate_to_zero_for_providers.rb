class DefaultHourlyRateToZeroForProviders < ActiveRecord::Migration
  def self.up
    change_column :providers, :hourly_rate, :decimal, :precision => 10, :scale => 2, :default => 0.0
  end

  def self.down
    change_column :providers, :hourly_rate, :decimal, :precision => 10, :scale => 2
  end
end
