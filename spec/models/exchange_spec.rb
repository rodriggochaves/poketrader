require "rails_helper"

RSpec.describe Exchange, type: :model do
  let(:exchange) { create(:exchange) }
  let(:left) { ExchangedPokemon.sides["left"] }
  let(:right) { ExchangedPokemon.sides["right"] }

  it "has many exchanged pokemons" do
    pokemons = [create(:charmander), create(:bulbasaur)]
    pokemons.map { |pokemon| create(:exchanged_pokemon, exchange: exchange, pokemon: pokemon) }

    expect(exchange.reload.exchanged_pokemons.map(&:class).uniq).to eq([ExchangedPokemon])
  end

  describe "#fair?" do
    let(:mewtwo) { create(:pokemon, name: "mewtwo", base_experience: 306) }

    it "returns true when exchanges two pokemons with close base experience" do
      create(:exchanged_pokemon, exchange: exchange, pokemon: create(:charmander), side: left)
      create(:exchanged_pokemon, exchange: exchange, pokemon: create(:bulbasaur), side: right)

      expect(exchange.fair?).to eq(true)
    end

    it "returns false when exchanges two pokemons with distant base experience" do
      create(:exchanged_pokemon, exchange: exchange, pokemon: create(:charmander), side: left)
      create(:exchanged_pokemon, exchange: exchange, pokemon: mewtwo, side: right)

      expect(exchange.fair?).to eq(false)
    end

    it "returns true when exchanges many small base experience pokemons for one big experience" do
      create_list(:exchanged_pokemon, 5, exchange: exchange, pokemon: create(:charmander), side: left)
      create(:exchanged_pokemon, exchange: exchange, pokemon: mewtwo, side: right)

      expect(exchange.fair?).to eq(true)
    end

    it "returns false when exchange is one sided" do
      create_list(:exchanged_pokemon, 2, exchange: exchange, pokemon: mewtwo, side: right)

      expect(exchange.fair?).to eq(false)
    end
  end
end
