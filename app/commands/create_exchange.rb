class CreateExchange
  def initialize(params)
    @left_side = params[:left]
    @right_side = params[:right]
  end

  def call
    exchange = Exchange.create
    exchange_pokemons(exchange)
  end

  def exchange_pokemons(exchange)
    left_pokemons = @left_side.map do |pokemon_name|
      pokemon = FindOrFetchPokemon.new(pokemon_name).call
      ExchangedPokemon.create(pokemon: pokemon, side: ExchangedPokemon.sides[:left], exchange: exchange)
    end
    right_pokemons = @right_side.map do |pokemon_name|
      pokemon = FindOrFetchPokemon.new(pokemon_name).call
      ExchangedPokemon.create(pokemon: pokemon, side: ExchangedPokemon.sides[:right], exchange: exchange)
    end
    left_pokemons + right_pokemons
  end
end
