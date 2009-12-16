class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.integer :provider_id
      t.integer :question_id
      t.integer :answer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
