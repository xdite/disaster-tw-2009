class CreateSourceTypes < ActiveRecord::Migration
  def self.up
    create_table :source_types do |t|
      t.string :name
      t.timestamps
    end
    add_column :posts, :source_type_id, :integer 
  end

  def self.down
    drop_table :source_types
    remove_cloumn :posts, :source_type_id
  end
end
