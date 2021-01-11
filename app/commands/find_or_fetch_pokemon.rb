# TODO: add dry transactions here
class FindOrFetchPokemon
  class PokemonNotFound < StandardError
  end

  attr_reader :name, :poke_api

  def initialize(name, api: PokeApi)
    @name = name
    @poke_api = api
  end

  def call
    create_pokemon unless pokemon
    pokemon
  rescue JSON::ParserError => exception
    handle_error(exception)
  end

  private

  def create_pokemon
    pokemon_data = poke_api.get(pokemon: name)
    @pokemon = Pokemon.create!(
      poke_index: pokemon_data.id,
      name: @name,
      base_experience: pokemon_data.base_experience
    )
  end

  def pokemon
    @pokemon ||= Pokemon.find_by(name: name)
  end

  def handle_error(error)
    raise PokemonNotFound, "'#{name}' is not a pokemon" if error.message.scan(/not found/i)

    raise error
  end
end
