#-*- coding: utf-8 -*-#
class Evolution < ActiveRecord::Base
  attr_accessible :evolves_from, :evolves_to, :evolves_by

  TRIGGERS = {
    1 => "Level Up",
    2 => "Trade",
    3 => "Use Item",
    4 => "Special"
  }

  SPECIAL_CODES = {
    5  => 'gender: ', # gender_id
    6  => 'location: ', # location_id
    7  => 'holding: ', # held_item_id
    8  => 'at: ', # time_of_day
    9  => 'must know: ', # known_move_id
    10 => 'must know type: ', # known_move_type_id
    11 => 'happiness: ', # minimum_happiness
    12 => 'beauty: ', # minimum_beauty
    13 => 'affection: ', # minimum_affection
    14 => 'relative physical stats: ', # relative_physical_stats
    15 => 'party must have species: ', # party_species_id
    16 => 'party must have type: ', # party_type_id
    17 => 'trade species must be: ', # trade_species_id -- must trade with species
    18 => 'needs rain', # needs_overworld_rain
    19 => 'upside down' # turn_upside_down
  }

  belongs_to :evo_from, :class_name => 'Pokemon', :foreign_key => 'evolves_from'
  belongs_to :evo_to, :class_name => 'Pokemon', :foreign_key => 'evolves_to'

  def evolved_from(get_name = true)
    pkmn = Pokemon.find(evolves_from)
    if get_name
      pkmn.name
    else
      pkmn
    end
  end

  def self.translate_special_id(code, special_id)
    special_id = special_id.to_s
    if Rails.env.development?
      puts "\t\tTranslating code: #{code}, id: #{special_id}."
      puts "\t\t(code is a #{code.class}, special_id is a #{special_id.class}"
    end
    case code
    when 5
      if special_id == '1' # need 'male' or 'female'
        return 'male'
      elsif special_id == '2'
        return 'female'
      end
    when 6
      require 'csv'
      CSV.foreach("#{Rails.root}/public/data/location_names.csv") do |row|
        if row[0] == special_id && row[1] == '9' # make sure to get english stuff
          return row[2].capitalize # need location name
        end
      end
    when 7
      require 'csv'
      CSV.foreach("#{Rails.root}/public/data/items.csv") do |row|
        if row[0] == special_id
          return row[1].capitalize # need item name
        end
      end
    when 8
      return special_id # 'day' or 'night'
    when 9
      require 'csv'
      CSV.foreach("#{Rails.root}/public/data/moves.csv") do |row|
        if row[0] == special_id
          return row[1].capitalize # need move name
        end
      end
    when 10
      return Poketype::POKETYPE_IDS[special_id.to_i] # find pokemon type name
      # can't use Poketype.find because ids might not match (until db gets dropped)
    when 11
      return special_id # just use what they give you for happiness
    when 12
      return special_id # ditto for beauty
    when 13
      return special_id # also affection
    when 14
      return special_id + "(don't really know what this means)" # wut :|
    when 15
      return "#{Pokemon.where(:species_id => special_id.to_i).first.name} (#{special_id})" # find pokemon name
    when 16
      return Poketype::POKETYPE_IDS[special_id.to_i] # find pokemon type name
      # can't use Poketype.find because ids might not match (until db gets dropped)
    when 17
      return "#{Pokemon.where(:species_id => special_id.to_i).first.name} (#{special_id})" # find pokemon name
    end
    raise 'Pokerror! Missing data'
  end
end