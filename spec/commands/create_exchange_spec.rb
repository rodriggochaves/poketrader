require "rails_helper"

RSpec.describe CreateExchange do
  let(:bulbasaur) { create(:bulbasaur) }
  let(:chamander) { create(:chamander) }
  let(:squirtle) { create(:squirtle) }
  let(:params) { { left: [chamander.name, squirtle.name], right: [bulbasaur.name] } }

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
