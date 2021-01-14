class FetchPokemon
  extend ApplicationService

  class PokemonNotFound < StandardError
  end

  attr_reader :name, :poke_api, :pokemon_data

  def initialize(name:, api: PokeApi)
    @name = name
    @poke_api = api
  end

  def call
    @pokemon_data = poke_api.get(pokemon: name)
    raise PokemonNotFound, "Empty pokemon name" unless pokemon_data.name.present?

    build_pokemon
  rescue JSON::ParserError => exception
    handle_error(exception)
  end

  private

  def build_pokemon
    Pokemon.new(
      poke_index: pokemon_data.id,
      name: pokemon_data.name,
      base_experience: pokemon_data.base_experience
    )
  end

  def handle_error(exception)
    raise PokemonNotFound, "'#{name}' is not a pokemon" if exception.message.scan(/not found/i)

    raise exception
  end
end
