require "rails_helper"

RSpec.describe Pokemon, type: :model do
  it "validates the name presence" do
    pokemon = build(:pokemon, name: "")
    expect(pokemon).to be_invalid
  end

  it "validates the poke index presence" do
    pokemon = build(:pokemon, poke_index: nil)
    expect(pokemon).to be_invalid
  end

  it "validates pokemons poke_index uniqueness" do
    create(:charmander)
    expect(build(:charmander)).to be_invalid
  end
end
