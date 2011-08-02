class AddOriginToPropMessage < ActiveRecord::Migration
  def self.up
    add_column :prop_messages, :origin_id, :integer
  end

  def self.down
  end
end
