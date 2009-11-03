class RenameEndorsementRequestRecipientsToEndorsers < ActiveRecord::Migration
  def self.up
    rename_table :endorsement_request_recipients, :endorsers
    rename_column :endorsements, :endorsement_request_recipient_id, :endorser_id
  end

  def self.down
    rename_column :endorsements, :endorser_id, :endorsement_request_recipient_id
    rename_table :endorsers, :endorsement_request_recipients
  end
end
