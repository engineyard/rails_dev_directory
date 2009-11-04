class CreateQuizResultAnswers < ActiveRecord::Migration
  def self.up
    create_table :quiz_result_answers do |t|
      t.integer :quiz_result_id
      t.integer :question_id
      t.integer :answer_id
      t.boolean :correct

      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_result_answers
  end
end
