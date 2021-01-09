require 'rails_helper'

RSpec.describe ExchangedPokemon, type: :model do
  describe "#side" do
    it "is valid with 'right'" do
      exchanged_pokemon = build(:exchanged_pokemon, side: ExchangedPokemon.sides['right'])
      expect(exchanged_pokemon).to be_valid
    end

    it "is valid with 'left'" do
      exchanged_pokemon = build(:exchanged_pokemon, side: ExchangedPokemon.sides['left'])
      expect(exchanged_pokemon).to be_valid
    end

    it "is invalid with nil" do
      exchanged_pokemon = build(:exchanged_pokemon, side: nil)
      expect(exchanged_pokemon).to be_invalid
    end

    it "is invalid with value outside of enum" do
      expect { build(:exchanged_pokemon, side: 'top') }.to raise_error(ArgumentError)
    end
  end

  it "belongs to pokemon" do
    exchanged_pokemon = build(:exchanged_pokemon)
    expect(exchanged_pokemon.pokemon).to be_instance_of(Pokemon)
  end

  it "belongs to an exchange" do
    exchanged_pokemon = build(:exchanged_pokemon)
    expect(exchanged_pokemon.exchange).to be_instance_of(Exchange)
  end
end
