class CreateTopCities < ActiveRecord::Migration
  def self.up
    create_table :top_cities do |t|
      t.string :city
      t.string :country
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :top_cities
  end
end
