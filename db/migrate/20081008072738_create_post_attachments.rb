class CreatePostAttachments < ActiveRecord::Migration
  def self.up
    create_table :post_attachments do |t|
      
      t.column :parent_id, :integer
      t.column :content_type, :string
      t.column :filename, :string    
      t.column :thumbnail, :string 
      t.column :size, :integer
      t.column :width, :integer
      t.column :height, :integer
      # basic attachment column
      
      t.integer :post_id
      t.integer :user_id
      
      t.timestamps
    end
    add_index :post_attachments, :post_id
    add_index :post_attachments, :user_id
  end

  def self.down
    drop_table :post_attachments
  end
end
