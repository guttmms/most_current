class CreateReceivedTables < ActiveRecord::Migration
  def self.up
    create_table :received_tables do |t|
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :received_tables
  end
end
