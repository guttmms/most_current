class CreateConnectionKeys < ActiveRecord::Migration
  def self.up
    create_table :connection_keys do |t|
      t.integer :key_id
      t.integer :connection_id

      t.timestamps
    end
  end

  def self.down
    drop_table :connection_keys
  end
end
