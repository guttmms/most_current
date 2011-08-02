class AddFieldToReceivedKey < ActiveRecord::Migration
  def self.up
    add_column :received_keys, :received_table_id, :integer
    add_column :received_keys, :key_id, :integer
    add_column :received_keys, :max_hops, :integer
  end

  def self.down
    remove_column :received_keys, :received_table_id
    remove_column :received_keys, :key_id
    remove_column :received_keys, :max_hops
  end
end
