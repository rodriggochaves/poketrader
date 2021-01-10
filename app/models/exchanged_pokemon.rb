class ExchangedPokemon < ApplicationRecord
  belongs_to :pokemon
  belongs_to :exchange

  validates :side, presence: true

  enum side: {
    left: 0,
    right: 1
  }

  def score
    pokemon.base_experience
  end
end
