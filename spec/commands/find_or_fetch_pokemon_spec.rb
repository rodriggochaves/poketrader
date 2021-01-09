require "rails_helper"

RSpec.describe FindOrFetchPokemon do
  subject(:find_pokemon) { FindOrFetchPokemon.new(name).call }
  let(:name) { "bulbasaur" }
  let(:base_experience) { 64 }
  let(:pokemon_api_double) { double(id: 1, name: name, base_experience: base_experience) }

  context "when querying a new pokemon" do
    before do
      allow(PokeApi).to receive(:get).and_return(pokemon_api_double)
    end

    it "expects to call PokeApi with the pokemon name" do
      expect(PokeApi).to receive(:get).with(pokemon: name)
      find_pokemon
    end

    # EXTERNAL DEPENDENCY
    it "expects to save in the database" do
      expect { find_pokemon }.to change(Pokemon, :count).by(1)
    end
  end

  context "when querying a existing pokemon" do
    before do
      Pokemon.create!(id: 1, name: name, base_experience: base_experience)
    end

    # EXTERNAL DEPENDENCY
    it "expects to not save in the database" do
      expect { find_pokemon }.not_to change(Pokemon, :count)
    end

    it "expects to return pokemon base experience" do
      pokemon = find_pokemon
      expect(pokemon.base_experience).to equal(base_experience)
    end
  end
end
