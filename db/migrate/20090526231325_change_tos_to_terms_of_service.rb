class ChangeTosToTermsOfService < ActiveRecord::Migration
  def self.up
    rename_column :providers, :tos, :terms_of_service
  end

  def self.down
    rename_column :providers, :terms_of_service, :tos
  end
end
