class Exchange < ApplicationRecord
  POKEMON_EXCHANGE_MAX_DIFF = 10

  has_many :exchanged_pokemons, dependent: :destroy

  validate :at_least_one_pokemon_on_each_side?

  scope :history, -> { order(created_at: :desc) }

  def add_pokemon(pokemon, side)
    exchanged_pokemons << ExchangedPokemon.new(pokemon: pokemon, side: side)
  end

  def fair?
    (side_score(&:left?) - side_score(&:right?)).abs < POKEMON_EXCHANGE_MAX_DIFF
  end

  def left_side
    pokemons_exchange_side(&:left?)
  end

  def right_side
    pokemons_exchange_side(&:right?)
  end

  private

  def side_score(&block)
    pokemons_exchange_side(&block).sum(&:score)
  end

  def pokemons_exchange_side(&block)
    exchanged_pokemons.select(&block)
  end

  def at_least_one_pokemon_on_each_side?
    return unless left_side.empty? || right_side.empty?

    errors.add(:exchanged_pokemons, "needs at least one pokemon on each side")
  end
end
