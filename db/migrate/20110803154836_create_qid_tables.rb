class CreateQidTables < ActiveRecord::Migration
  def self.up
    create_table :qid_tables do |t|
      t.integer :user_id
      t.string :qid
      t.timestamps
    end
  end

  def self.down
    drop_table :qids
  end
end
