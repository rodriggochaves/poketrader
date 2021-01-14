require "rails_helper"

RSpec.describe Exchange, type: :model do
  let(:exchange) { build(:exchange) }
  let(:left) { ExchangedPokemon.sides["left"] }
  let(:right) { ExchangedPokemon.sides["right"] }

  it "expects to be invalid without at least one pokemon on each side" do
    expect(exchange).to be_invalid
  end

  it "expects to be valid with one pokemon on each side" do
    exchange.add_pokemon(build(:charmander), left)
    exchange.add_pokemon(build(:bulbasaur), right)

    expect(exchange).to be_valid
  end

  it "has many exchanged pokemons" do
    exchange.add_pokemon(build(:charmander), left)
    exchange.add_pokemon(build(:bulbasaur), right)

    expect(exchange.exchanged_pokemons.map(&:class).uniq).to eq([ExchangedPokemon])
  end
end
