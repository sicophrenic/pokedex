json.array!(@poketypes) do |poketype|
  json.extract! poketype, 
  json.url poketype_url(poketype, format: :json)
end
