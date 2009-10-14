class AddRecommendationsCountToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :recommendations_count, :integer, :default => 0
  end

  def self.down
    remove_column :providers, :recommendations_count
  end
end
