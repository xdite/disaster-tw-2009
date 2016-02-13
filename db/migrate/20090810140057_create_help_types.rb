class CreateHelpTypes < ActiveRecord::Migration
  def self.up
    create_table :help_types do |t|
      t.string :name
      t.timestamps
    end
    
    HelpType.create!(:name => "求救")
    HelpType.create!(:name => "尋人")
    HelpType.create!(:name => "物資")
    
    add_column :posts, :help_type_id, :integer, :default => "1"
    
  end

  def self.down
    drop_table :help_types
  end
end
