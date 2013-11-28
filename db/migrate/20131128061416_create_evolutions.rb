#-*- coding: utf-8 -*-#
class CreateEvolutions < ActiveRecord::Migration
  def self.up
    create_table :evolutions do |t|
      t.integer :evolves_from, :null => false
      t.integer :evolves_to, :null => false
      t.string :evolves_by, :null => false, :default => 'Level Up'

      t.timestamps
    end
    add_index :evolutions, [:evolves_from]
    add_index :evolutions, [:evolves_from, :evolves_to], :unique => true
    add_index :evolutions, [:evolves_by]
  end

  def self.down
    drop_table :evolutions
  end
end
