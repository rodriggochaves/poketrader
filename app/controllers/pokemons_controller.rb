class PokemonsController < ApplicationController
  def index
    pokemons = GetPokemons.new(search: pokemon_search_params).call
    render json: pokemons
  end

  def new; end

  def create
    pokemon = FetchPokemon.new(name: pokemon_name).call
    pokemon.save!
    redirect_to new_pokemon_path, notice: "Pokemon created successfully"
  rescue FetchPokemon::PokemonNotFound => exception
    redirect_to new_pokemon_path, flash: { error: exception.message }
  end

  private

  def pokemon_name
    params.permit(:name)[:name]
  end

  def pokemon_search_params
    params[:query]
  end
end
