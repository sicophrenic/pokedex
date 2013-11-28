#-*- coding: utf-8 -*-#
class CreatePoketypes < ActiveRecord::Migration
  def change
    create_table :poketypes do |t|
      t.string :name, :null => false, :unique => true
      t.string :color_code, :null => false, :unique => true

      t.timestamps
    end
    add_index :poketypes, [:name], :unique => true
    add_index :poketypes, [:color_code], :unique => true
    add_index :poketypes, [:name, :color_code], :unique => true
  end
end
