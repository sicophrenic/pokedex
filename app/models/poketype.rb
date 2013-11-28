#-*- coding: utf-8 -*-#
class Poketype < ActiveRecord::Base
  attr_accessible :name, :color_code

  has_and_belongs_to_many :pokemons
end
