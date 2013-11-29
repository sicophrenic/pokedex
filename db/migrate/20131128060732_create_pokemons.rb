#-*- coding: utf-8 -*-#
class CreatePokemons < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.integer :poke_id, :null => false, :unique => true
      t.string :name, :null => false, :unique => true
      t.integer :species_id, :null => false, :unique => true

      t.timestamps
    end
    add_index :pokemons, [:poke_id], :unique => true
    add_index :pokemons, [:name], :unique => true
    add_index :pokemons, [:poke_id, :name], :unique => true
    add_index :pokemons, [:species_id], :unique => false
  end
end
