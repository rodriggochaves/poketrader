class ExchangedPokemon < ApplicationRecord
  belongs_to :pokemon
  enum side: {
    left: 0,
    right: 1
  }
end
