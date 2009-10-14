class CreatePortfolioItems < ActiveRecord::Migration
  def self.up
    create_table :portfolio_items do |t|
      t.string :name
      t.string :url
      t.text :description
      t.string :year_completed
      t.integer :provider_id

      t.timestamps
    end
  end

  def self.down
    drop_table :portfolio_items
  end
end
