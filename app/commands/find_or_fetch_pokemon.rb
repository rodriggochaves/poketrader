# TODO add dry transactions here

class FindOrFetchPokemon
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def call
    unless pokemon
      pokemon_data = PokeApi.get(pokemon: @name)
      @pokemon = Pokemon.create(id: pokemon_data.id, name: @name, base_experience: pokemon_data.base_experience)
    end
    pokemon
  end

  private
  def pokemon
    @pokemon ||= Pokemon.find_by(name: name)
  end
end
