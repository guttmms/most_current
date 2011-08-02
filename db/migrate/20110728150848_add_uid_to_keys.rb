class AddUidToKeys < ActiveRecord::Migration
  def self.up
    #add_column :keys, :uid, :string
    remove_column :keys, :uid
    add_column :keys, :profile_id, :integer
    rename_column :keys, :profile_id, :user_id
  end

  def self.down
    remove_column :users, :uid
  end
end
