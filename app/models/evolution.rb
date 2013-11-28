#-*- coding: utf-8 -*-#
class Evolution < ActiveRecord::Base
  attr_accessible :evolves_from, :evolves_to, :evolves_by

  belongs_to :evo_from, :class_name => 'Pokemon', :foreign_key => 'evolves_from'
  belongs_to :evo_to, :class_name => 'Pokemon', :foreign_key => 'evolves_to'
end
