#-*- coding: utf-8 -*-#
class AddPokemonAndPoketypeJoinTable < ActiveRecord::Migration
  def self.up
    create_table :pokemons_poketypes do |t|
      t.integer :pokemon_id
      t.integer :poketype_id

      t.timestamps
    end
    add_index :pokemons_poketypes, [:pokemon_id, :poketype_id], :unique => true
  end

  def self.down
    drop_table :pokemons_poketypes
  end
end
