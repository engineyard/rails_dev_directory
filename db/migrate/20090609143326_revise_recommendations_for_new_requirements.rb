class ReviseRecommendationsForNewRequirements < ActiveRecord::Migration
  def self.up
    remove_column :recommendations, :comments
    add_column :recommendations, :year_hired, :string
    add_column :recommendations, :position, :string
    add_column :recommendations, :endorsement, :text
  end

  def self.down
    remove_column :recommendations, :year_hired
    remove_column :recommendations, :position
    remove_column :recommendations, :endorsement
    add_column :recommendations, :comments, :text
  end
end
