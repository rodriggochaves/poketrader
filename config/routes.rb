Rails.application.routes.draw do
  root "exchanges#new"

  resources "exchanges", only: [:index, :new, :create]
  post "exchanges/simulate" => "exchanges#simulate"

  resources "pokemons", only: [:index, :new, :create]
end
