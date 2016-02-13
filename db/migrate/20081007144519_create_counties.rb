class CreateCounties < ActiveRecord::Migration
  def self.up
    create_table :counties do |t|
      t.string :name
      t.string :location
      t.integer :posts_count , :default => "0"
      t.timestamps
    end
    add_index :counties, :posts_count
  end

  def self.down
    drop_table :counties
  end
end
