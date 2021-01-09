require "rails_helper"

RSpec.describe CreateExchange do
  let(:params) { { left: ["charmander", "squirtle"], right: ["bulbasaur"] } }

  before do
    Pokemon.create!(id: 4, name: "charmander", base_experience: 62)
    Pokemon.create!(id: 5, name: "squirtle", base_experience: 63)
    Pokemon.create!(id: 6, name: "bulbasaur", base_experience: 64)
  end

  it "creates three new pokemon trades" do
    expect { CreateExchange.new(params).call }.to change(ExchangedPokemon, :count).by(3)
  end

  it "creates a new trade" do
    expect { CreateExchange.new(params).call }.to change(Exchange, :count).by(1)
  end

  it "expects to correctly save sides" do
    exchanged_pokemons = CreateExchange.new(params).call
    expect(exchanged_pokemons.map(&:side)).to eq(["left", "left", "right"])
  end
end
