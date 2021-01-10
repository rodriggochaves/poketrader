require "rails_helper"

RSpec.describe Exchange, type: :model do
  it "has many exchanged pokemons" do
    exchange = create(:exchange)
    pokemons = [create(:charmander), create(:bulbasaur)]
    pokemons.map { |pokemon| create(:exchanged_pokemon, exchange: exchange, pokemon: pokemon) }

    expect(exchange.reload.exchanged_pokemons.map(&:class).uniq).to eq([ExchangedPokemon])
  end
end
