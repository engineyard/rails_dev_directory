class CreateRfps < ActiveRecord::Migration
  def self.up
    create_table :rfps do |t|
      t.integer :provider_id
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :email
      t.string :phone_number
      t.string :project_name
      t.boolean :nda_required
      t.text :project_description
      t.text :platform_requirements
      t.integer :budget
      t.date :due_date
      t.string :time_zone
      t.string :office_location
      t.boolean :general_liability_insurance
      t.boolean :professional_liability_insurance
      t.text :additional_services

      t.timestamps
    end
  end

  def self.down
    drop_table :rfps
  end
end
