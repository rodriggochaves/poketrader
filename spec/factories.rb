FactoryBot.define do
  factory :pokemon, aliases: [:bulbasaur], class: Pokemon do
    id { 1 }
    name { "bulbasaur" }
    base_experience { 64 }
  end

  factory :chamander, class: Pokemon do
    id { 4 }
    name { "chamander" }
    base_experience { 62 }
  end

  factory :squirtle, class: Pokemon do
    id { 7 }
    name { "squirtle" }
    base_experience { 63 }
  end

  factory :exchanged_pokemon do
    side { ExchangedPokemon.sides['right'] }
    pokemon
    exchange
  end


  factory :exchange do
  end
end
