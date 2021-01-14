class CheckFairness
  POKEMON_EXCHANGE_MAX_DIFF = 10

  extend ApplicationService

  attr_reader :exchange

  def initialize(exchange:)
    @exchange = exchange
  end

  def call
    absolute_difference < POKEMON_EXCHANGE_MAX_DIFF
  end

  private

  def absolute_difference
    (exchange.left_side_pokemons.sum(&:score) - exchange.right_side_pokemons.sum(&:score)).abs
  end
end
