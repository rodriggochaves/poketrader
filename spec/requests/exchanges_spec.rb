require "rails_helper"

RSpec.describe "Exchanges", type: :request do
  # TODO: add webmock to fail these tests if they are requesting to PokeAPI
  describe "POST /exchanges" do
    subject(:create_exchange_request) do
      post "/exchanges", params: { left: [bulbasaur.name], right: [charmander.name] }
    end

    let(:bulbasaur) { create(:bulbasaur) }
    let(:charmander) { create(:charmander) }

    it "responds with HTTP 302" do
      create_exchange_request
      expect(response).to have_http_status(302)
    end

    it "sends a successful notice" do
      create_exchange_request
      expect(flash[:notice]).to eq("Your Pokemons was sent successfully")
    end

    it "creates a new exchange" do
      expect { create_exchange_request }.to change(Exchange, :count).by(1)
    end
  end
end
