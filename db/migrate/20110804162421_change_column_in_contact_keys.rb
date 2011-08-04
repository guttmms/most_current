class ChangeColumnInContactKeys < ActiveRecord::Migration
  def self.up
    rename_column :contact_keys, :contact_id, :linked_contact_id
    
  end

  def self.down
    rename_column :contact_keys, :linked_contact_id, :contact_id
  end
end
