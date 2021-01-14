require "rails_helper"

RSpec.describe SaveExchange do
  it "creates a new exchange" do
    exchange = build(:exchange)
    exchange.add_pokemon(build(:charmander), ExchangedPokemon.sides[:left])
    exchange.add_pokemon(build(:bulbasaur), ExchangedPokemon.sides[:right])

    expect { SaveExchange.call(exchange: exchange) }.to change(Exchange, :count).by(1)
  end
end
