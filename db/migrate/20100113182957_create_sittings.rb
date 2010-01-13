class CreateSittings < ActiveRecord::Migration
  def self.up
    create_table :sittings do |t|
      t.integer :quiz_id
      t.integer :provider_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sittings
  end
end
