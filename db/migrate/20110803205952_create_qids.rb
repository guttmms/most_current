class CreateQids < ActiveRecord::Migration
  def self.up
    create_table :qids do |t|
      t.string :qid
      t.timestamps
    end
  end

  def self.down
    drop_table :qids
  end
end
