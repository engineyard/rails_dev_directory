class SaveAllProviders < ActiveRecord::Migration
  def self.up
    Provider.each do |provider|
      provider.update_attribute(:recommendations_count, provider.recommendations.approved.count) if provider
    end
  end

  def self.down
  end
end