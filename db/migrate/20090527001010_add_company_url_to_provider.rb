class AddCompanyUrlToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :company_url, :string
  end

  def self.down
    remove_column :providers, :company_url
  end
end
