require "rails_helper"

RSpec.describe ExchangeHistory do
  it "returns a list of exchanges ordered by created time" do
    Timecop.freeze(Time.zone.today - 1.day)
    create(:charmander)
    create(:bulbasaur)
    yesterday_exchange = CreateExchange.new(left: ["charmander"], right: ["bulbasaur"]).call

    Timecop.travel(Time.zone.today)
    today_exchange = CreateExchange.new(left: ["bulbasaur"], right: ["charmander"]).call

    expect(ExchangeHistory.new.call).to eq([today_exchange, yesterday_exchange])
  end

  after do
    Timecop.return
  end
end
