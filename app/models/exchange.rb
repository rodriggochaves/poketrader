class Exchange < ApplicationRecord
  has_many :exchanged_pokemons, dependent: :destroy

  scope :history, -> { order(created_at: :desc) }

  def fair?
    (side_score(&:left?) - side_score(&:right?)).abs < 10
  end

  def left_pokemons
    exchanged_pokemons.includes(:pokemon).select(&:left?)
  end

  def right_pokemons
    exchanged_pokemons.includes(:pokemon).select(&:right?)
  end

  private

  def side_score(&block)
    side_exchanged_pokemons = exchanged_pokemons.includes(:pokemon).select(&block)
    side_exchanged_pokemons.sum(&:score)
  end
end
