class AddColumnToForwardTable < ActiveRecord::Migration
  def self.up
    add_column :forward_tables, :user_id, :integer
    rename_column :prop_messages, :forward_table_id, :key_id
  end

  def self.down
    remove_column :forward_tables, :user_id
    rename_column :prop_messages, :forward_table_id, :key_id
  end
end
