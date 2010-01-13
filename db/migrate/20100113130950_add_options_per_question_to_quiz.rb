class AddOptionsPerQuestionToQuiz < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :options_per_question, :integer
  end

  def self.down
    remove_column :quizzes, :options_per_question
  end
end
