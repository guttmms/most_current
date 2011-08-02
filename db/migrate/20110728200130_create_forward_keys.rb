class CreateForwardKeys < ActiveRecord::Migration
  def self.up
    create_table :forward_keys do |t|
      t.integer :forward_table_id
      t.integer :key_id
      t.timestamps
    end
  end

  def self.down
    drop_table :forward_keys
  end
end
