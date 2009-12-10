class CreateBehaviorConfigs < ActiveRecord::Migration
  def self.up
    create_table :behavior_configs, :force => true do |t|
      t.string :key
      t.string :value
      t.timestamps
    end
    
    add_index :behavior_configs, :key
  end

  def self.down
    remove_index :behavior_configs, :key
    drop_table :behavior_configs
  end
end
