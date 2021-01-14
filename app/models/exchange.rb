class Exchange < ApplicationRecord
  POKEMON_EXCHANGE_MAX_DIFF = 10

  has_many :exchanged_pokemons, dependent: :destroy

  validate :at_least_one_pokemon_on_each_side?

  scope :history, -> { order(created_at: :desc) }

  def add_pokemon(pokemon, side)
    exchanged_pokemons << ExchangedPokemon.new(pokemon: pokemon, side: side)
  end

  def left_side_pokemons
    exchanged_pokemons.select(&:left?)
  end

  def right_side_pokemons
    exchanged_pokemons.select(&:right?)
  end

  private

  def at_least_one_pokemon_on_each_side?
    return unless left_side_pokemons.empty? || right_side_pokemons.empty?

    errors.add(:exchanged_pokemons, "needs at least one pokemon on each side")
  end
end
