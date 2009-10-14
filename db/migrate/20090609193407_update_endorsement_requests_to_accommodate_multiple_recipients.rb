class UpdateEndorsementRequestsToAccommodateMultipleRecipients < ActiveRecord::Migration
  def self.up
    remove_column :endorsement_requests, :recipient
    add_column :endorsement_requests, :recipients, :text
  end

  def self.down
    remove_column :endorsement_requests, :recipients
    add_column :endorsement_requests, :recipient, :string
  end
end
