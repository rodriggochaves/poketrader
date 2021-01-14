require "rails_helper"

RSpec.describe SavePokemon do
  subject(:save_pokemon) { SavePokemon.call(pokemon: pokemon) }

  let(:pokemon) { build(:pokemon) }

  it "creates a new pokemon" do
    expect { save_pokemon }.to change(Pokemon, :count).by(1)
  end

  it "when already registered, raises a SavePokemon::AlreadyExistError" do
    create(:pokemon)
    expect { save_pokemon }.to raise_error(SavePokemon::AlreadyExistError)
  end
end
