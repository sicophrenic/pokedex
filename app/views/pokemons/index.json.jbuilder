json.array!(@pokemons) do |pokemon|
  json.extract! pokemon, 
  json.url pokemon_url(pokemon, format: :json)
end
