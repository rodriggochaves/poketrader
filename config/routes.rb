Rails.application.routes.draw do
  root "trades#new"

  resources "trades", only: [:index, :new]
end
