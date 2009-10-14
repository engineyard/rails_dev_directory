class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.integer :rfp_id
      t.integer :provider_id

      t.timestamps
    end
    add_index :requests, :provider_id
    add_index :requests, :rfp_id
  end

  def self.down
    remove_index :requests, :rfp_id
    remove_index :requests, :provider_id
    mind
    drop_table :requests
  end
end
