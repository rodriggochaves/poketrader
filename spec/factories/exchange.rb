FactoryBot.define do
  factory :exchanged_pokemon do
    side { ExchangedPokemon.sides["right"] }
    pokemon
    exchange
  end

  factory :exchange do
  end
end
