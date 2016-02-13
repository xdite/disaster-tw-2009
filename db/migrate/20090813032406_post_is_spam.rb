class PostIsSpam < ActiveRecord::Migration
  def self.up
    add_column :posts, :spams_count , :integer, :default => 0
  end

  def self.down
    remove_column :post, :spams_count
  end
end
