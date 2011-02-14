class BonusMigration < ActiveRecord::Migration
  def self.up
    create_table :bonuses do |t|
      t.integer :game_id, :null => false
      t.string  :name
      t.boolean :show_name, :null => false, :default => false 
      t.text    :question
      t.integer :price, :null => false, :default => 0
      t.text    :hint
      t.string  :hint_title
      t.timestamps
    end
    add_index :bonuses, :game_id

    create_table :levels_bonuses do |t|
      t.integer  :level_id
      t.integer  :bonus_id
    end
   add_index :levels_bonuses, [:level_id, :bonus_id], :unique => true
    rename_column :questions, :level_id, :parent_id
    add_column    :questions, :parent_type, :string, :null => false, :default => 'Level'
    add_index :questions, [:parent_id, :parent_type]

    add_column :game_passings, :passed_bonuses, :text

    

  end

  def self.down
    drop_table :bonuses
    drop_table :levels_bonuses
    remove_index :questions, [:parent_id, :parent_type]
    rename_column :questions, :parent_id, :level_id
    remove_column :questions, :parent_type
    remove_column :game_passings, :passed_bonuses
  end
end