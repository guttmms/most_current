class CreateReceivedKeys < ActiveRecord::Migration
  def self.up
    create_table :received_keys do |t|
      t.integer :received_table_id
      t.integer :key_id
      t.integer :max_hops
      t.timestamps
    end
  end

  def self.down
    drop_table :received_keys
  end
end
