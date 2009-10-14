class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.string :company_name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :phone_number
      t.string :email
      t.integer :company_size
      t.string :logo_file_name

      t.timestamps
    end
  end

  def self.down
    drop_table :providers
  end
end
