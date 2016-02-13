class SpamIp < ActiveRecord::Migration
  def self.up
    add_column :spams, :created_ip, :string
    add_index :spams, [:created_ip, :post_id]
  end

  def self.down
    remove_column :spams, :created_ip, :string
  end
  
end
