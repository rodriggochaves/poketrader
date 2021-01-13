FactoryBot.define do
  factory :pokemon, aliases: [:bulbasaur], class: Pokemon do
    poke_index { 1 }
    name { "bulbasaur" }
    base_experience { 64 }
  end

  factory :charmander, class: Pokemon do
    poke_index { 4 }
    name { "charmander" }
    base_experience { 62 }
  end

  factory :squirtle, class: Pokemon do
    poke_index { 7 }
    name { "squirtle" }
    base_experience { 63 }
  end

end
