class AddAasmStateToRecommendation < ActiveRecord::Migration
  class Recommendation < ActiveRecord::Base; end
  def self.up
    add_column :recommendations, :aasm_state, :string
    add_index :recommendations, :aasm_state
    Recommendation.all.each do |recommendation|
      recommendation.aasm_state = "approved" if recommendation.approved?
      recommendation.aasm_state = "rejected" unless recommendation.approved?
      recommendation.save
    end
    remove_column :recommendations, :approved
  end

  def self.down
    add_column :recommendations, :approved, :boolean

    Recommendation.all.each do |recommendation|
      recommendation.approved = true if recommendation.aasm_state == "approved"
      recommendation.approved = false if recommendation.aasm_state == "rejected"
      recommendation.save
    end    

    remove_index :recommendations, :aasm_state
    
    remove_column :recommendations, :aasm_state
  end
end
