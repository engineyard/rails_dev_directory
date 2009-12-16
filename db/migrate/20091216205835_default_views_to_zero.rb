class DefaultViewsToZero < ActiveRecord::Migration
  def self.up
    change_column_default :providers, :views, 0
  end

  def self.down
    change_column_default :providers, :views, nil
  end
end
