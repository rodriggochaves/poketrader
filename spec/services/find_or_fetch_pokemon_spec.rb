require "rails_helper"

RSpec.describe FindOrFetchPokemon do
  subject(:find_pokemon) { FindOrFetchPokemon.new(name, api: api).call }

  let(:name) { "bulbasaur" }
  let(:base_experience) { 64 }
  let(:poke_index) { 1 }
  let(:api) { double("Poke API", get: api_response) }
  let(:api_response) { double(id: 1, name: name, base_experience: base_experience, poke_index: poke_index) }

  context "when querying a new pokemon" do
    it "expects to call PokeApi with the pokemon name" do
      expect(api).to receive(:get).with(pokemon: name)
      find_pokemon
    end

    # TODO: EXTERNAL DEPENDENCY
    it "expects to save in the database" do
      expect { find_pokemon }.to change(Pokemon, :count).by(1)
    end
  end

  context "when querying a existing pokemon" do
    before do
      create(:bulbasaur)
    end

    it "expects to not save in the database" do
      expect { find_pokemon }.not_to change(Pokemon, :count)
    end

    it "expects to return pokemon base experience" do
      pokemon = find_pokemon
      expect(pokemon.base_experience).to equal(base_experience)
    end
  end

  context "when querying a misspelled pokemon" do
    before do
      allow(api).to receive(:get).and_raise(JSON::ParserError.new("783: unexpected token at 'Not Found'"))
    end

    it "expects to raise a PokemonNotFound exception" do
      expect { find_pokemon }.to raise_error(FindOrFetchPokemon::PokemonNotFound)
    end
  end
end
