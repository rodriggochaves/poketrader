class Exchange < ApplicationRecord
  has_many :exchanged_pokemons, dependent: :destroy

  scope :history, -> { order(created_at: :desc) }

  def fair?
    (side_score(&:left?) - side_score(&:right?)).abs < 10
  end

  def left_pokemons
    pokemons_exchange_side(&:left?)
  end

  def right_pokemons
    pokemons_exchange_side(&:right?)
  end

  private

  def side_score(&block)
    pokemons_exchange_side(&block).sum(&:score)
  end

  def pokemons_exchange_side(&block)
    exchanged_pokemons.includes(:pokemon).select(&block)
  end
end
