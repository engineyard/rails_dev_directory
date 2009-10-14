class CreateAudits < ActiveRecord::Migration
  def self.up
    create_table :audits do |t|
      t.string :auditable_type
      t.integer :auditable_id
      t.string :action
      t.integer :user_id

      t.timestamps
    end
    
    add_index :audits, [:auditable_type, :action], :name => "auditable_index"
    add_index :audits, :user_id
    add_index :audits, [:user_id, :auditable_type], :name => "auditable_user_index"
    add_index :audits, [:auditable_type, :auditable_id], :name => "auditable_object"
  end

  def self.down
    remove_index :audits, :name => :auditable_object
    remove_index :audits, :name => :auditable_user_index
    remove_index :audits, :user_id
    remove_index :audits, :name => :auditable_index
    drop_table :audits
  end
end