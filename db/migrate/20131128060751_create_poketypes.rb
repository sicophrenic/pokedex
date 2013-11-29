#-*- coding: utf-8 -*-#
class CreatePoketypes < ActiveRecord::Migration
  def change
    create_table :poketypes do |t|
      t.string :name, :null => false, :unique => true
      t.string :color, :null => false

      t.timestamps
    end
    add_index :poketypes, [:name], :unique => true
    add_index :poketypes, [:name, :color], :unique => true
  end
end
