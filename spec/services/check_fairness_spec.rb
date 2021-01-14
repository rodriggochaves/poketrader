require "rails_helper"

RSpec.describe CheckFairness do
  subject(:check_fairness) { CheckFairness.call(exchange: exchange) }

  let(:exchange) { build(:exchange) }
  let(:left) { ExchangedPokemon.sides["left"] }
  let(:right) { ExchangedPokemon.sides["right"] }

  it "returns true when exchanges two pokemons with close base experience" do
    exchange.add_pokemon(build(:charmander), left)
    exchange.add_pokemon(build(:bulbasaur), right)

    expect(check_fairness).to be_truthy
  end

  it "returns false when exchanges two pokemons with distant base experience" do
    exchange.add_pokemon(build(:charmander), left)
    exchange.add_pokemon(build(:mewtwo), right)

    expect(check_fairness).to be_falsy
  end

  it "returns true when exchanges many small base experience pokemons for one big experience" do
    build_list(:charmander, 5).map { |charmander| exchange.add_pokemon(charmander, left) }
    exchange.add_pokemon(build(:mewtwo), right)

    expect(check_fairness).to be_truthy
  end

  it "returns false when exchange is one sided" do
    build_list(:charmander, 2).map { |charmander| exchange.add_pokemon(charmander, left) }

    expect(check_fairness).to be_falsy
  end
end
