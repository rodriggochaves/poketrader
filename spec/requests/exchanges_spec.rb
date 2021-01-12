require "rails_helper"

RSpec.describe "Exchanges", type: :request do
  let(:bulbasaur) { create(:bulbasaur) }
  let(:charmander) { create(:charmander) }
  let(:mewtwo) { create(:pokemon, id: 150, name: "mewtwo", base_experience: 306) }
  let(:params) { { left: [bulbasaur.name], right: [charmander.name] } }

  xdescribe "POST /exchanges" do
    subject(:create_exchange_request) do
      post "/exchanges", params: params
    end

    context "when pokemon names are found" do
      it "responds with HTTP 302" do
        create_exchange_request
        expect(response).to have_http_status(302)
      end

      it "creates a new exchange" do
        expect { create_exchange_request }.to change(Exchange, :count).by(1)
      end

      it "sends a flash message if the exchange was fair" do
        create_exchange_request
        expect(flash[:notice]).to eq("Pokemons successfully exchanged\nIt was a fair trade!")
      end

      context "if the exchange was not fair" do
        let(:params) { { left: [bulbasaur.name], right: [mewtwo.name] } }

        it "sends a flash alert message " do
          create_exchange_request
          expect(flash[:alert]).to eq("Pokemons successfully exchanged\nIt wasn't a fair trade!")
        end
      end
    end

    context "when a pokemon name ins't found" do
      let(:create_exchange_command) { double("CreateExchange") }

      before do
        allow(CreateExchange).to receive(:new).and_return(create_exchange_command)
        allow(create_exchange_command).to receive(:call).and_raise(
          FindOrFetchPokemon::PokemonNotFound.new("'Chamander' is not a pokemon")
        )
      end

      it "responds with HTTP 302" do
        create_exchange_request
        expect(response).to have_http_status(302)
      end

      it "sends an alert flash" do
        create_exchange_request
        expect(flash[:error]).to eq("'Chamander' is not a pokemon")
      end

      it "expects to not create a new exchange" do
        expect { create_exchange_request }.not_to change(Exchange, :count)
      end
    end

    context "when there is a unknown error" do
      let(:create_exchange_command) { double("CreateExchange") }

      before do
        allow(CreateExchange).to receive(:new).and_return(create_exchange_command)
        allow(create_exchange_command).to receive(:call).and_raise(StandardError.new("Unknown error"))
      end

      it "responds with HTTP 302" do
        create_exchange_request
        expect(response).to have_http_status(302)
      end

      it "sends an alert flash" do
        create_exchange_request
        expect(flash[:error]).to eq("Unknown Error! Try again later!")
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
