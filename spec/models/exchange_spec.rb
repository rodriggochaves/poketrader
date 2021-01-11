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

  describe "#fair?" do
    let(:mewtwo) { build(:pokemon, name: "mewtwo", base_experience: 306) }

    it "returns true when exchanges two pokemons with close base experience" do
      exchange.add_pokemon(build(:charmander), left)
      exchange.add_pokemon(build(:bulbasaur), right)

      expect(exchange.fair?).to eq(true)
    end

    it "returns false when exchanges two pokemons with distant base experience" do
      exchange.add_pokemon(build(:charmander), left)
      exchange.add_pokemon(mewtwo, right)

      expect(exchange.fair?).to eq(false)
    end

    it "returns true when exchanges many small base experience pokemons for one big experience" do
      build_list(:charmander, 5).map { |charmander| exchange.add_pokemon(charmander, left) }
      exchange.add_pokemon(mewtwo, right)

      expect(exchange.fair?).to eq(true)
    end

    it "returns false when exchange is one sided" do
      build_list(:charmander, 2).map { |charmander| exchange.add_pokemon(charmander, left) }

      expect(exchange.fair?).to eq(false)
    end
  end
end
