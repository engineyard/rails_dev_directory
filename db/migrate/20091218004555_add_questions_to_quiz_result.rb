class AddQuestionsToQuizResult < ActiveRecord::Migration
  def self.up
    add_column :quiz_results, :questions, :integer
  end

  def self.down
    remove_column :quiz_results, :questions
  end
end
