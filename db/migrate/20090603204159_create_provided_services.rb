class CreateProvidedServices < ActiveRecord::Migration
  def self.up
    create_table :provided_services do |t|
      t.integer :technology_type_id
      t.integer :provider_id

      t.timestamps
    end
  end

  def self.down
    drop_table :provided_services
  end
end
