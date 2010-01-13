class AddMoreFieldsToQuiz < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :total_questions, :integer
    add_column :quizzes, :questions_per_quiz, :integer
  end

  def self.down
    remove_column :quizzes, :questions_per_quiz
    remove_column :quizzes, :total_questions
  end
end
