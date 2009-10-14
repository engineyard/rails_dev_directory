class RemoveTermsAndConditionsFromProvider < ActiveRecord::Migration
  def self.up
    remove_column :providers, :terms_of_service
  end

  def self.down
    add_column :providers, :terms_of_service, :boolean
  end
end
