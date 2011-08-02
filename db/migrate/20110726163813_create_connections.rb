class CreateConnections < ActiveRecord::Migration
  def self.up
    create_table :connections do |t|
      t.integer :user_id
      t.text :headline
      t.string :uid
      t.string :last_name
      t.string :picture_url
      t.string :location
      t.string :industry
      t.string :first_name

      t.timestamps
    end
  end

  def self.down
    drop_table :connections
  end
end
