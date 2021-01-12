require "rails_helper"

RSpec.describe "Pokemons", type: :request do
  describe "GET /pokemons/new" do
    it "returns HTTP 200" do
      get new_pokemon_path
      expect(response).to have_http_status(200)
    end
  end

end
