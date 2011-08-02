class CreatePropMessages < ActiveRecord::Migration
  def self.up
    create_table :prop_messages do |t|
      t.integer :forward_table_id
      t.string :pid
      t.integer :hops_remaining
      t.integer :hops_covered
      t.timestamps
    end
  end

  def self.down
    drop_table :prop_messages
  end
end
