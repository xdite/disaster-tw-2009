class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.string :site_url
      t.string :yahoo_userhash
      t.string :gender
      t.text :description
      
      t.boolean :is_admin
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      
      t.integer :posts_count , :default => "0"
      t.integer :post_comments_count, :default => "0"
    end
    add_index :users, :login, :unique => true
    add_index :users, :posts_count
    add_index :users, :post_comments_count
  end

  def self.down
    drop_table "users"
  end
end
