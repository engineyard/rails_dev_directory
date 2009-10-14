class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :recommendations do |t|
      t.string :name
      t.string :company
      t.string :email
      t.string :url
      t.text :comments
      t.boolean :approved
      t.integer :provider_id

      t.timestamps
    end
  end

  def self.down
    drop_table :recommendations
  end
end
