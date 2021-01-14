require "rails_helper"

RSpec.describe "Pokemons", type: :request do
  describe "GET" do
    let!(:charmander) { create(:charmander) }

    it "returns HTTP 200" do
      get pokemons_path, params: { query: "char" }
      expect(response).to have_http_status(200)
    end

    it "returns a pokemon list" do
      get pokemons_path, params: { query: "char" }
      expect(JSON.parse(response.body)).to include(hash_including({
                                                                    "name" => charmander.name,
                                                                    "base_experience" => charmander.base_experience
                                                                  }))
    end
  end

  describe "GET /pokemons/new" do
    it "returns HTTP 200" do
      get new_pokemon_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /pokemons" do
    subject(:create_pokemon) { post pokemons_path, params: { name: name } }

    let(:name) { "groudon" }

    context "with valid params" do
      before do
        stub_request(:get, "https://pokeapi.co/api/v2/pokemon/groudon")
          .to_return(status: 200, body: { name: "groudon", base_experience: 306, id: 383 }.to_json)
      end

      it "redirects to new_pokemon_path" do
        create_pokemon
        expect(response).to redirect_to(new_pokemon_path)
      end

      it "sends a flash notice" do
        create_pokemon
        expect(flash[:notice]).to eq("Pokemon created successfully")
      end

      it "creates a new pokemon querying the PokeAPI" do
        expect { create_pokemon }.to change(Pokemon, :count).by(1)
      end
    end

    context "with empty params" do
      before do
        stub_request(:get, "https://pokeapi.co/api/v2/pokemon/groudon")
          .to_return(status: 200, body: { name: "", base_experience: 306, id: 383 }.to_json)
      end

      it "redirects to new_pokemon_path" do
        create_pokemon
        expect(response).to redirect_to(new_pokemon_path)
      end

      it "sends a flash error" do
        create_pokemon
        expect(flash[:error]).to eq("Empty pokemon name")
      end
    end

    context "with invalid params" do
      let(:name) { "pudim" }

      before do
        stub_request(:get, "https://pokeapi.co/api/v2/pokemon/#{name}")
          .to_return(status: 200, body: "not found")
      end

      it "redirects to new_pokemon_path" do
        create_pokemon
        expect(response).to redirect_to(new_pokemon_path)
      end

      it "sends a flash error" do
        create_pokemon
        expect(flash[:error]).to eq("'pudim' is not a pokemon")
      end
    end
  end
end
