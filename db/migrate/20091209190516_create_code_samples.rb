class CreateCodeSamples < ActiveRecord::Migration
  def self.up
    create_table :code_samples do |t|
      t.string :name
      t.text :code
      t.integer :provider_id
      t.string :aasm_state
      t.integer :score

      t.timestamps
    end
  end

  def self.down
    drop_table :code_samples
  end
end
