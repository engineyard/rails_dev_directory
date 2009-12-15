class AddFieldsToQuiz < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :skill_level, :string
    add_column :quizzes, :time_limit, :integer
  end

  def self.down
    remove_column :quizzes, :time_limit
    remove_column :quizzes, :skill_level
  end
end
