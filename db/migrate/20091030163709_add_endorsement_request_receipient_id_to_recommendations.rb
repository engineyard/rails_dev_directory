class AddEndorsementRequestReceipientIdToRecommendations < ActiveRecord::Migration
  def self.up
    add_column :recommendations, :endorsement_request_recipient_id, :integer
  end

  def self.down
    remove_column :recommendations, :endorsement_request_recipient_id
  end
end
