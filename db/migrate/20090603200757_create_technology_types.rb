class CreateTechnologyTypes < ActiveRecord::Migration
  def self.up
    create_table :technology_types do |t|
      t.string :name
      t.string :service_type
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :technology_types
  end
end
