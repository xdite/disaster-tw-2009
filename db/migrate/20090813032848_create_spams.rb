class CreateSpams < ActiveRecord::Migration
  def self.up
    create_table :spams do |t|
      t.integer :post_id
      t.integer :content
      t.timestamps
    end
  end

  def self.down
    drop_table :spams
  end
end
