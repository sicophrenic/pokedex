#-*- coding: utf-8 -*-#
class SearchController < ApplicationController
  def search_page
  end

  def find_pokemon
    @query = params[:query]
    @pokemons = Pokemon.where('name like ?', @query)
    if @pokemons.length == 1
      redirect_to pokemon_path(@pokemons.take!.id)
    end
  end
end
