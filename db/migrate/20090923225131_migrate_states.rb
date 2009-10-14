class MigrateStates < ActiveRecord::Migration
  def self.up
    Provider.each do |provider|
      provider.update_attribute(
        :state_province,
        State.by_name(provider.state_province)
          ) if State.by_name(provider.state_province)
    end
  end

  def self.down
  end
end
