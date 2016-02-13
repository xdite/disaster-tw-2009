class PostIp < ActiveRecord::Migration
  def self.up
    change_column :posts, :created_ip, :string
    change_column :post_comments, :created_ip, :string
  end

  def self.down
    change_column :posts, :created_ip, :integer
    change_column :post_comments, :created_ip, :string
  end
end
