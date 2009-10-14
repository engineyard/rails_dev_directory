class SetDefaultMinBudget < ActiveRecord::Migration
  def self.up
    Provider.each do |provider|
      provider.update_attribute(:min_budget, provider.min_budget || 0)
    end
  end

  def self.down
  end
end
