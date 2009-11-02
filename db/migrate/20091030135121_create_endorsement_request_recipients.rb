class CreateEndorsementRequestRecipients < ActiveRecord::Migration
  def self.up
    create_table :endorsement_request_recipients do |t|
      t.integer :endorsement_request_id
      t.string :email, :nullable => false
      t.string :validation_token, :nullable => false
    end
  end

  def self.down
    drop_table :endorsement_request_recipients
  end
end
