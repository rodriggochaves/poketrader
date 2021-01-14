class CheckFairness
  extend ApplicationService

  attr_reader :exchange

  def initialize(exchange:)
    @exchange = exchange
  end

  def call
    absolute_difference < 10
  end

  private

  def absolute_difference
    (exchange.left_side_pokemons.sum(&:score) - exchange.right_side_pokemons.sum(&:score)).abs
  end
end
