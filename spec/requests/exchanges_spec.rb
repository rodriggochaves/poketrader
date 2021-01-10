require "rails_helper"

RSpec.describe "Exchanges", type: :request do
  describe "POST /exchanges" do
    subject(:create_exchange_request) do
      post "/exchanges", params: { left: [bulbasaur.name], right: [charmander.name] }
    end

    let(:bulbasaur) { create(:bulbasaur) }
    let(:charmander) { create(:charmander) }

    context "when pokemon names are found" do
      it "responds with HTTP 302" do
        create_exchange_request
        expect(response).to have_http_status(302)
      end

      it "sends a notice flash" do
        create_exchange_request
        expect(flash[:notice]).to eq("Your Pokemons was sent successfully")
      end

      it "creates a new exchange" do
        expect { create_exchange_request }.to change(Exchange, :count).by(1)
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
        expect(flash[:alert]).to eq("'Chamander' is not a pokemon")
      end

      it "expects to not create a new exchange" do
        expect { create_exchange_request }.not_to change(Exchange, :count)
      end
    end
  end
end
