require "rails_helper"

RSpec.describe SimulateExchange do
  subject(:exchange) { SimulateExchange.new(params).call }

  let(:bulbasaur) { create(:bulbasaur) }
  let(:charmander) { create(:charmander) }
  let(:squirtle) { create(:squirtle) }
  let(:params) { { left: [charmander.name, squirtle.name], right: [bulbasaur.name] } }

  it "returns a Exchange instance" do
    expect(exchange).to be_instance_of(Exchange)
  end

  describe "the left side" do
    it "expects to include two pokemons" do
      expect(exchange.left_side.map(&:pokemon)).to match_array([charmander, squirtle])
    end
  end

  describe "the right side" do
    it "expects to include one pokemon" do
      expect(exchange.right_side.map(&:pokemon)).to match_array([bulbasaur])
    end
  end

  describe "#fair?" do
    it "expects to be unfair" do
      expect(exchange.fair?).to be_falsy
    end
  end
end
