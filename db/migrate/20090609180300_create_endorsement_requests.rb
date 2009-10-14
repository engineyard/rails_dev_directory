class CreateEndorsementRequests < ActiveRecord::Migration
  def self.up
    create_table :endorsement_requests do |t|
      t.string :recipient
      t.integer :provider_id
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :endorsement_requests
  end
end
