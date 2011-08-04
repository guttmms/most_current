class ChangeColumnsInQidTable < ActiveRecord::Migration
  def self.up
    remove_column :qid_tables, :qid
      
    end
  end

  def self.down
    add_column :qid_tables, :qid, :string
    
end
