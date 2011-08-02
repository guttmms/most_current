class CreateFriendMinHops < ActiveRecord::Migration
  def self.up
    create_table :friend_min_hops do |t|
      t.integer :received_key_id
      t.integer :friend_id
      t.integer :h_min

      t.timestamps
    end
  end

  def self.down
    drop_table :friend_min_hops
  end
end
