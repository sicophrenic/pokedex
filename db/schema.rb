# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131128061416) do

  create_table "evolutions", force: true do |t|
    t.integer  "evolves_from",                      null: false
    t.integer  "evolves_to",                        null: false
    t.string   "evolves_by",   default: "Level Up", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evolutions", ["evolves_by"], name: "index_evolutions_on_evolves_by"
  add_index "evolutions", ["evolves_from", "evolves_to"], name: "index_evolutions_on_evolves_from_and_evolves_to", unique: true
  add_index "evolutions", ["evolves_from"], name: "index_evolutions_on_evolves_from"

  create_table "pokemons", force: true do |t|
    t.integer  "poke_id",    null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pokemons", ["name"], name: "index_pokemons_on_name", unique: true
  add_index "pokemons", ["poke_id", "name"], name: "index_pokemons_on_poke_id_and_name", unique: true
  add_index "pokemons", ["poke_id"], name: "index_pokemons_on_poke_id", unique: true

  create_table "pokemons_poketypes", force: true do |t|
    t.integer  "pokemon_id"
    t.integer  "poketype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pokemons_poketypes", ["pokemon_id", "poketype_id"], name: "index_pokemons_poketypes_on_pokemon_id_and_poketype_id", unique: true

  create_table "poketypes", force: true do |t|
    t.string   "name",       null: false
    t.string   "color_code", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "poketypes", ["color_code"], name: "index_poketypes_on_color_code", unique: true
  add_index "poketypes", ["name", "color_code"], name: "index_poketypes_on_name_and_color_code", unique: true
  add_index "poketypes", ["name"], name: "index_poketypes_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
