require "rails_helper"

RSpec.describe ExchangeHistory do
  it "returns a list of exchanges ordered by created time" do
    Timecop.freeze(Time.zone.today - 1.day)
    create(:charmander)
    create(:bulbasaur)
    yesterday_exchange = SimulateExchange.call(left: ["charmander"], right: ["bulbasaur"])
    yesterday_exchange.save!

    Timecop.travel(Time.zone.today)
    today_exchange = SimulateExchange.call(left: ["bulbasaur"], right: ["charmander"])
    today_exchange.save!

    expect(ExchangeHistory.call).to eq([today_exchange, yesterday_exchange])
  end

  after do
    Timecop.return
  end
end
