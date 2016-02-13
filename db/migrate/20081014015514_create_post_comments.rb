class CreatePostComments < ActiveRecord::Migration
  def self.up
    create_table :post_comments do |t|
      t.text :content
      t.string :username
      t.integer :post_id
      t.integer :user_id
      t.integer :created_ip
      t.timestamps
    end
    add_index :post_comments, :created_ip
  end

  def self.down
    drop_table :post_comments
  end
end
