#-*- coding: utf-8 -*-#
class Pokemon < ActiveRecord::Base
  attr_accessible :poke_id, :name

  has_and_belongs_to_many :poketypes
  has_many :evolutions, :foreign_key => 'evolves_from'
  has_many :devolutions, :class_name => 'Evolution', :foreign_key => 'evolves_to'
end
