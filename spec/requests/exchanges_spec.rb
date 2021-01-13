require "rails_helper"

RSpec.describe "Exchanges", type: :request do
  let(:bulbasaur) { create(:bulbasaur) }
  let(:charmander) { create(:charmander) }
  let(:mewtwo) { create(:pokemon, id: 150, name: "mewtwo", base_experience: 306) }
  let(:params) { { left: [bulbasaur.name], right: [charmander.name] } }

  describe "POST /exchanges" do
    subject(:create_exchange_request) do
      post "/exchanges", params: params
    end

    context "with valid params" do
      it "responds with HTTP 302" do
        create_exchange_request
        expect(response).to have_http_status(200)
      end

      it "creates a new exchange" do
        expect { create_exchange_request }.to change(Exchange, :count).by(1)
      end
    end
  end

  describe "POST /exchanges/simulate" do
    subject(:simulate_exchange) { post "/exchanges/simulate", params: params }
    let(:response_body) { JSON.parse(response.body) }

    it "returns HTTP 200" do
      simulate_exchange
      expect(response).to have_http_status(200)
    end

    it "returns the exchange fairness" do
      simulate_exchange
      expect(response_body).to include({ "fair" => true })
    end
  end
end
