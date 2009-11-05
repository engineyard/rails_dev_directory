class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.string :company
      t.string :position
      t.string :year_hired
      t.string :project
      t.text :message
      t.string :aasm_state

      t.integer :provider_id

      t.timestamps
    end
  end

  def self.down
    drop_table :feedbacks
  end
end
