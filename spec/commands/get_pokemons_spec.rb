require "rails_helper"

RSpec.describe GetPokemons do
  it "returns a list of pokemons" do
    bulbasaur = create(:bulbasaur)
    charmander = create(:charmander)

    expect(GetPokemons.new.call).to match_array([bulbasaur, charmander])
  end
end
