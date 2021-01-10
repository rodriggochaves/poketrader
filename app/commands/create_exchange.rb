class CreateExchange
  attr_reader :exchange, :left_side, :right_side

  def initialize(params)
    @left_side = params[:left]
    @right_side = params[:right]
  end

  def call
    @exchange = Exchange.create
    exchange_pokemons
  end

  private

  def exchange_pokemons
    left_pokemons = exchange_side(left_side, ExchangedPokemon.sides[:left])
    right_pokemons = exchange_side(right_side, ExchangedPokemon.sides[:right])
    left_pokemons + right_pokemons
  end

  def exchange_side(pokemon_names, side)
    pokemon_names.map do |pokemon_name|
      pokemon = FindOrFetchPokemon.new(pokemon_name).call
      ExchangedPokemon.create(pokemon: pokemon, side: side, exchange: exchange)
    end
  end
end
