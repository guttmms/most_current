class ChangePropMessageRelation < ActiveRecord::Migration
  def self.up
    rename_column :prop_messages, :key_id, :forward_key_id
  end

  def self.down
    rename_column :prop_messages, :key_id, :forward_key_id
  end
end
