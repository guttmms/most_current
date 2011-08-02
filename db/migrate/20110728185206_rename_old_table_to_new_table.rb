class RenameOldTableToNewTable < ActiveRecord::Migration
  def self.up
    rename_table :connections, :linked_contacts
    rename_column :connection_keys, :connection_id, :contact_id
    rename_table :connection_keys, :contact_keys
    
  end

  def self.down
    rename_table :linked_contacts, :connections
  end
end
