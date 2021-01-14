class PokemonsController < ApplicationController
  def index
    pokemons = GetPokemons.call(search: pokemon_search_params)
    render json: pokemons
  end

  def new; end

  def create
    pokemon = FetchPokemon.call(name: pokemon_params[:name])
    SavePokemon.call(pokemon: pokemon)
    redirect_to new_pokemon_path, notice: "Pokemon created successfully"
  rescue FetchPokemon::PokemonNotFound, SavePokemon::AlreadyExistError => exception
    redirect_to new_pokemon_path, flash: { error: exception.message }
  end

  private

  def pokemon_params
    params.permit(:name)
  end

  def pokemon_search_params
    params[:query]
  end
end
