require "rails_helper"

RSpec.describe CreateExchange do
  subject(:create_exchange) { CreateExchange.new(params, options).call }

  let(:bulbasaur) { create(:bulbasaur) }
  let(:charmander) { create(:charmander) }
  let(:squirtle) { create(:squirtle) }
  let(:params) { { left: [charmander.name, squirtle.name], right: [bulbasaur.name] } }
  let(:options) { {} }

  it "creates three new pokemon exchanges" do
    expect { create_exchange }.to change(ExchangedPokemon, :count).by(3)
  end

  it "creates a new exchanges" do
    expect { create_exchange }.to change(Exchange, :count).by(1)
  end

  it "expects to correctly save sides" do
    expect(create_exchange.exchanged_pokemons.map(&:side)).to eq(%w[left left right])
  end

  it "returns a Exchange instance" do
    expect(create_exchange).to be_instance_of(Exchange)
  end

  context "when there is a unknown pokemon" do
    let(:params) { { left: [charmander.name, squirtle.name], right: ["bulbasauro"] } }
    let(:find_pokemon_instance) { double("FindPokemon instance") }
    let(:find_pokemon_class) { double("FindPokemon Class", new: find_pokemon_instance) }
    let(:options) { { find_pokemon: find_pokemon_class } }

    before do
      allow(find_pokemon_instance).to receive(:call).and_raise(FindOrFetchPokemon::PokemonNotFound)
    end

    it "expects to raise an error" do
      expect { create_exchange }.to raise_error(FindOrFetchPokemon::PokemonNotFound)
    end

    it "expects not to create a exchange" do
      expect do
        create_exchange
      rescue StandardError
        nil
      end.not_to change(Exchange, :count)
    end
  end
end
