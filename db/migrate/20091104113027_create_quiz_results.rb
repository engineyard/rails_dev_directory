class CreateQuizResults < ActiveRecord::Migration
  def self.up
    create_table :quiz_results do |t|
      t.integer :provider_id
      t.integer :quiz_id
      t.boolean :passed

      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_results
  end
end
