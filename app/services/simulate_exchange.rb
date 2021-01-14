class SimulateExchange
  attr_reader :exchange, :left_side, :right_side

  def initialize(params)
    @left_side = params[:left]
    @right_side = params[:right]
  end

  def call
    @exchange = Exchange.new
    exchange_pokemons
    exchange
  end

  private

  def exchange_pokemons
    exchange_side(left_side, ExchangedPokemon.sides[:left])
    exchange_side(right_side, ExchangedPokemon.sides[:right])
  end

  def exchange_side(pokemon_names, side)
    pokemon_names.map do |pokemon_name|
      pokemon = Pokemon.find_by(name: pokemon_name)
      exchange.add_pokemon(pokemon, side)
    end
  end
end
