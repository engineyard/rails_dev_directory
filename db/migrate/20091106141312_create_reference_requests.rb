class CreateReferenceRequests < ActiveRecord::Migration
  def self.up
    create_table :reference_requests do |t|
      t.string :name
      t.string :email
      t.text :message
      t.string :validation_token

      t.integer :endorsement_id

      t.timestamps
    end
  end

  def self.down
    drop_table :reference_requests
  end
end
