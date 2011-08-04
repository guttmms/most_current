class CreateQidTableQids < ActiveRecord::Migration
  def self.up
    create_table :qid_table_qids do |t|
      t.integer :qid_table_id
      t.integer :qid_id
      t.timestamps
    end
  end

  def self.down
    drop_table :qid_table_qids
  end
end
