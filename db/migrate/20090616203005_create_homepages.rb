class CreateHomepages < ActiveRecord::Migration
  def self.up
    create_table :homepages do |t|
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :homepages
  end
end
