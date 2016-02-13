class CreateUserBuddyIcons < ActiveRecord::Migration
  def self.up
    create_table :user_buddy_icons do |t|
      t.column :type,  :string
      t.column :parent_id, :integer
      t.column :content_type, :string
      t.column :filename, :string    
      t.column :thumbnail, :string 
      t.column :size, :integer
      t.column :width, :integer
      t.column :height, :integer
      
      #for user buddy icon
      t.column :user_id, :integer

      t.timestamps
    end
    
    add_index :user_buddy_icons, :user_id
  end

  def self.down
    drop_table :user_buddy_icons
  end
end
