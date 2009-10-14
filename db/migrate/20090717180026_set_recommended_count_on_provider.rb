class SetRecommendedCountOnProvider < ActiveRecord::Migration
  def self.up
    Provider.all.each do |provider|
      provider.recommendations_count = provider.recommendations.approved.count
      provider.save
    end
  end

  def self.down
  end
end
