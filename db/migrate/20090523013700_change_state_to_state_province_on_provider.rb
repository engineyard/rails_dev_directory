class ChangeStateToStateProvinceOnProvider < ActiveRecord::Migration
  def self.up
    rename_column :providers, :state, :state_province
  end

  def self.down
    rename_column :providers, :state_province, :state
  end
end