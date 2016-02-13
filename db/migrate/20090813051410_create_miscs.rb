class CreateMiscs < ActiveRecord::Migration
  def self.up
    create_table :miscs do |t|
      t.text :content
      t.string :misc_type
      t.timestamps
    end
  end

  def self.down
    drop_table :miscs
  end
end
