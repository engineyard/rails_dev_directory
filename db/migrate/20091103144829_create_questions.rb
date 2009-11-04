class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :quiz_id
      t.text :text
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
