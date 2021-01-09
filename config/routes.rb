Rails.application.routes.draw do
  root "exchanges#new"

  resources "exchanges", only: [:index, :new, :create]
end
