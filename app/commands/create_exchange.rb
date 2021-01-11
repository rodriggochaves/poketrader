class CreateExchange
  attr_reader :exchange, :left_side, :right_side, :find_pokemon

  def initialize(params, **options)
    @left_side = params[:left]
    @right_side = params[:right]
    @find_pokemon = options[:find_pokemon] || FindOrFetchPokemon
  end

  def call
    @exchange = Exchange.new
    exchange_pokemons
    exchange.save!
    exchange
  end

  private

  def exchange_pokemons
    exchange_side(left_side, ExchangedPokemon.sides[:left])
    exchange_side(right_side, ExchangedPokemon.sides[:right])
  end

  def exchange_side(pokemon_names, side)
    pokemon_names.map do |pokemon_name|
      pokemon = find_pokemon.new(pokemon_name).call
      exchange.add_pokemon(pokemon, side)
    end
  end
end
