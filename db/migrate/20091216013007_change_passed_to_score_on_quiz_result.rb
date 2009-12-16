class ChangePassedToScoreOnQuizResult < ActiveRecord::Migration
  def self.up
    rename_column :quiz_results, :passed, :score
    change_column :quiz_results, :score, :integer
  end

  def self.down
    change_column :quiz_results, :score, :string
    rename_column :quiz_results, :score, :passed
  end
end
