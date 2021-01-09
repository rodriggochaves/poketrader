class ExchangedPokemon < ApplicationRecord
  belongs_to :pokemon
  belongs_to :exchange

  enum side: {
    left: 0,
    right: 1
  }
end
