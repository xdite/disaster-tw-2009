class CreateUrls < ActiveRecord::Migration
  def self.up
    create_table :urls do |t|
      t.string :link
      t.string :title
      t.string :ppt_url
      t.string :state
      t.string :processing_error_message
      # 
      
      t.integer :post_id
      
      t.timestamps
    end
    
    add_index :urls, :post_id
  end

  def self.down
    drop_table :urls
  end
end
