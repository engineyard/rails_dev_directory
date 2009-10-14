class AddMarketingDescriptionToProviders < ActiveRecord::Migration
  def self.up
    add_column :providers, :marketing_description, :text
  end

  def self.down
    remove_column :providers, :marketing_description
  end
end
