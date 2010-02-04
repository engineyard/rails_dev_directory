class SaveAllProvidersAgain < ActiveRecord::Migration
  def self.up
    Provider.each(&:save)
  end

  def self.down
  end
end
