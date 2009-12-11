class AddResultsToCodeSample < ActiveRecord::Migration
  def self.up
    add_column :code_samples, :reek_result, :integer
    add_column :code_samples, :flay_result, :integer
    add_column :code_samples, :flog_result, :decimal, :precision => 8, :scale => 2
    add_column :code_samples, :roodi_result, :integer
    add_column :code_samples, :saikuro_result, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :code_samples, :saikuro_result
    remove_column :code_samples, :roodi_result
    remove_column :code_samples, :flog_result
    remove_column :code_samples, :flay_result
    remove_column :code_samples, :reek_result
  end
end
