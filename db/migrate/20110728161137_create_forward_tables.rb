class CreateForwardTables < ActiveRecord::Migration
  def self.up
    create_table :forward_tables do |t|
      t.integer :user_id
      

      t.timestamps
    end
  end

  def self.down
    drop_table :forward_tables
  end
end
