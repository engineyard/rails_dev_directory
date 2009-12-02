class RenameRecommendationsToEndorsements < ActiveRecord::Migration
  def self.up
    rename_table :recommendations, :endorsements
    rename_column :providers, :recommendations_count, :endorsements_count
  end

  def self.down
    rename_column :providers, :endorsements_count, :recommendations_count
    rename_table :endorsements, :recommendations
  end
end
