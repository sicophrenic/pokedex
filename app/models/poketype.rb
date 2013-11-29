#-*- coding: utf-8 -*-#
class Poketype < ActiveRecord::Base
  attr_accessible :name, :color

  COLOR_CODES = {
    "Normal" => "#A8A878",
    "Fire" => "#F08030",
    "Water" => "#6890F0",
    "Electric" => "#F8D030",
    "Grass" => "#78C850",
    "Ice" => "#98D8D8",
    "Fighting" => "#C03028",
    "Poison" => "#A040A0",
    "Ground" => "#E0C068",
    "Flying" => "#A890F0",
    "Psychic" => "#F85888",
    "Bug" => "#A8B820",
    "Rock" => "#B8A038",
    "Ghost" => "#705898",
    "Dragon" => "#7038F8",
    "Dark" => "#705848",
    "Steel" => "#B8B8D0",
    "Fairy" => "#F0B6BC"
  }

  POKETYPE_IDS = {
    1  => "Normal",
    2  => "Fighting",
    3  => "Flying",
    4  => "Poison",
    5  => "Ground",
    6  => "Rock",
    7  => "Bug",
    8  => "Ghost",
    9  => "Steel",
    10 => "Fire",
    11 => "Water",
    12 => "Grass",
    13 => "Electric",
    14 => "Psychic",
    15 => "Ice",
    16 => "Dragon",
    17 => "Dark",
    18 => "Fairy",
    19 => "Unknown",
    20 => "Shadow",
  }

  has_and_belongs_to_many :pokemons
end
