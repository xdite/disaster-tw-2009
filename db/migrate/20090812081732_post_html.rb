class PostHtml < ActiveRecord::Migration
  def self.up
    add_column :posts, :content_html, :text
  end

  def self.down
    remove_column :posts, :content_html
  end
end
