require "rails_helper"

RSpec.describe GetPokemons do
  it "returns a empty list when search string is empty" do
    expect(GetPokemons.call(search: "")).to eq([])
  end

  it "returns a list of pokemons with matching name" do
    create(:bulbasaur)
    charmander = create(:charmander)

    expect(GetPokemons.call(search: "char")).to match_array([charmander])
  end
end
