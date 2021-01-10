class Exchange < ApplicationRecord
  has_many :exchanged_pokemons

  def fair?
    (side_score(&:left?) - side_score(&:right?)).abs < 10
  end

  private

  def side_score(&block)
    side_exchanged_pokemons = exchanged_pokemons.includes(:pokemon).select(&block)
    side_exchanged_pokemons.sum(&:score)
  end
end
