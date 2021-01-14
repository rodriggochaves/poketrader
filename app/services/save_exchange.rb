class SaveExchange
  extend ApplicationService

  attr_reader :exchange

  def initialize(exchange:)
    @exchange = exchange
  end

  def call
    exchange.save!
  end
end
