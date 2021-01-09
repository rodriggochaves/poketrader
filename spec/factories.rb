FactoryBot.define do
  factory :pokemons, aliases: [:bulbasaur], class: Pokemon do
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
end
