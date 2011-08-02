class CreateKeys < ActiveRecord::Migration
  def self.up
    create_table :keys do |t|
      t.integer :profile_id
      t.string :keyword

      t.timestamps
    end
  end

  def self.down
    drop_table :keys
  end
end
