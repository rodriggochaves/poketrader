require "rails_helper"

RSpec.describe FetchPokemon do
  subject(:fetch_pokemon) { FetchPokemon.call(name: name, api: api) }

  let(:name) { "groudon" }
  let(:api) { double("Poke API", get: pokemon) }
  let(:pokemon) { double(id: 1, name: name, base_experience: 302, poke_index: 383) }

  context "when querying a valid name" do
    it "expects to call PokeApi with the pokemon name" do
      expect(api).to receive(:get).with(pokemon: name)
      fetch_pokemon
    end

    it "returns an instance of Pokemon" do
      expect(fetch_pokemon).to be_instance_of(Pokemon)
    end
  end

  context "when querying a empty string" do
    let(:name) { "" }
    let(:pokemon) { double(id: 1, name: nil) }

    it "raises an error PokemonNotFound" do
      expect { fetch_pokemon }.to raise_error(FetchPokemon::PokemonNotFound)
    end
  end

  context "when querying a invalid name" do
    let(:name) { "pudim" }

    before do
      allow(api).to receive(:get).and_raise(JSON::ParserError)
    end

    it "raises an error PokemonNotFound" do
      expect { fetch_pokemon }.to raise_error(FetchPokemon::PokemonNotFound)
    end
  end

  context "when an unknown error happens" do
    before do
      allow(api).to receive(:get).and_raise(StandardError.new("unknown error"))
    end

    it "expects to raise a PokemonNotFound exception" do
      expect { fetch_pokemon }.to raise_error(StandardError)
    end
  end
end
