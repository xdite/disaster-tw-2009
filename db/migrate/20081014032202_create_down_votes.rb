class CreateDownVotes < ActiveRecord::Migration
  def self.up
    create_table :down_votes do |t|
      t.integer :post_id
      t.integer :created_ip
      t.timestamps
    end
    add_index :down_votes, :created_ip
    add_index :down_votes, :post_id
  end

  def self.down
    drop_table :down_votes
  end
end
