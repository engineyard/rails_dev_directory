ActiveRecord::Schema.define(:version => 0) do
  create_table :behavior_configs, :force => true do |t|
    t.string :key
    t.string :value
  end
end