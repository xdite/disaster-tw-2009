class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :county_id
      t.integer :user_id
      t.string :subject
      t.text :content
      t.integer :down_votes_count, :default => "0"
      t.integer :post_comments_count, :default => "0"
      t.integer :created_ip
      t.timestamps
    end
    add_index :posts, :created_ip
    add_index :posts, :county_id
    add_index :posts, :user_id
    add_index :posts, :post_comments_count
  end

  def self.down
    drop_table :posts
  end
end
