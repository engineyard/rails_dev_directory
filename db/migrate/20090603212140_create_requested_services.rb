class CreateRequestedServices < ActiveRecord::Migration
  def self.up
    create_table :requested_services do |t|
      t.integer :rfp_id
      t.string :name
      t.string :service_type
      t.timestamps
    end
  end

  def self.down
    drop_table :requested_services
  end
end
