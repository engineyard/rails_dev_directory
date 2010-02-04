class AddAttemptsToQuiz < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :attempts, :integer
  end

  def self.down
    remove_column :quizzes, :attempts
  end
end
