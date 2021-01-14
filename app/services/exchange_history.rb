class ExchangeHistory
  extend ApplicationService

  def call
    Exchange.history
  end
end
