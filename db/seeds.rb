#-*- coding: utf-8 -*-#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

def mod_capitalize(s)
  return s.slice(0,1).capitalize + s.slice(1..-1)
end

# Types
if Poketype.count != 18
  Poketype.delete_all
  puts '-> Creating Poketypes'
  CSV.foreach("#{Rails.root}/public/data/types.csv") do |row|
    next if row[0] == 'id'
    type = row[1].capitalize
    Poketype.create!(:name => type, :color => Poketype::COLOR_CODES[type] || '#000000')
  end
end

# Pokemon
if Pokemon.count != 778
  Pokemon.delete_all
  puts '-> Creating Pokemons'
  CSV.foreach("#{Rails.root}/public/data/pokemon.csv") do |row|
    next if row[0] == 'id'
    poke_id = row[0]
    name = row[1].capitalize
    Pokemon.create!(:name => name, :poke_id => poke_id, :species_id => row[2])
  end
  puts '-> Assigning types'
  CSV.foreach("#{Rails.root}/public/data/pokemon_types.csv") do |row|
    next if row[0] == 'pokemon_id'
    Pokemon.where(:poke_id => row[0].to_i).first.poketypes << Poketype.find(row[1].to_i)
  end
end

# Evolutions
# Level up: check row[4] for minimum level
# Trade: check row[7] for held item
# Use item: check row[3] for item id
# Special: ?????
# --------------------------------------------------
# 3  - evolution_trigger_id
# 4  - trigger_item_id
# 5  - minimum_level
# 6  - gender_id
# 7  - location_id
# 8  - held_item_id
# 9  - time_of_day
# 10 - known_move_id
# 11 - known_move_type_id
# 12 - minimum_happiness
# 13 - minimum_beauty
# 14 - minimum_affection
# 15 - relative_physical_stats
# 16 - party_species_id
# 17 - party_type_id
# 18 - trade_species_id -- must trade with species
# 19 - needs_overworld_rain
# 20 - turn_upside_down
if true # Evolution.count != 364
  Evolution.delete_all

  puts '-> Parsing Evolutions'
  EVOLUTION_IDS = {}
  CSV.foreach("#{Rails.root}/public/data/pokemon_species.csv") do |row|
    next if row[0] == 'id'
    if row[3]
      EVOLUTION_IDS[row[0].to_i] = row[3].to_i
    end
  end

  puts '-> Creating Evolutions'
  CSV.foreach("#{Rails.root}/public/data/pokemon_evolution.csv") do |row|
    next if row[0] == 'id'
    puts "\tRow: #{row}"

    evolves_to_id = row[1].to_i
    # evolves_from_id = evolves_to_id - 1
    evolves_from_id = EVOLUTION_IDS[evolves_to_id]
    evolves_by_id = row[2].to_i if row[2].present?
    next unless evolves_by_id.in?(Evolution::TRIGGERS.keys)

    evolves_by_string = ''
    if evolves_by_id == 1
      evolves_by_string << "Evolves at level #{row[4]}." if row[4].present?
    elsif evolves_by_id == 2
      held_item_id = row[7]
      held_item = Evolution.translate_special_id(7, held_item_id) if row[7]
      evolves_by_string << "Trade for evolve" + (row[7].nil? ? '.' : " while holding #{held_item}.")
    elsif evolves_by_id == 3
      item_id = row[3]
      item = Evolution.translate_special_id(7, item_id)
      evolves_by_string << "Use #{item} to evolve."
    elsif evolves_by_id == 4
      evolves_by_string << "Special evolve."
    end

    extras = []
    (5..17).each do |code|
      next if code == 7 && evolves_by_id == 2 # don't want duplicate 'holding' clauses
      if row[code].present?
        extras << (Evolution::SPECIAL_CODES[code] + Evolution.translate_special_id(code, row[code]))
      end
    end
    (18..19).each do |code|
      if row[code] == 1
        extras << Evolution::SPECIAL_CODES[code]
      end
    end
    if extras.count > 0
      if evolves_by_string.length > 0
        evolves_by_string += ' '
      end
      extras = extras.map do |extra|
        mod_capitalize(extra)
      end
      evolves_by_string += extras.join(', ')
      evolves_by_string += '.'
      evolves_by_string = mod_capitalize(evolves_by_string)
    end
    evolves_by_string = mod_capitalize(evolves_by_string)

    puts "\tEvolution from: #{evolves_from_id}, Evolution to: #{evolves_to_id}, Evolution by: #{evolves_by_string}"
    if evolution = Evolution.where(:evolves_to => evolves_to_id, :evolves_from => evolves_from_id).first
      evolution.evolves_by += " Or #{evolves_by_string}"
      evolution.save!
    else
      Evolution.create!(
        :evolves_to => evolves_to_id,
        :evolves_from => evolves_from_id,
        :evolves_by => evolves_by_string)
    end
  end
end