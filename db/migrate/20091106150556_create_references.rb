class CreateReferences < ActiveRecord::Migration
  def self.up
    create_table :references do |t|
      t.text :message
      
      t.integer :reference_request_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :references
  end
end
