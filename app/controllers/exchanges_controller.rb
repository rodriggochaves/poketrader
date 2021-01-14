class ExchangesController < ApplicationController
  def new; end

  def index
    @exchanges = ExchangeHistory.call
  end

  def create
    exchange = SimulateExchange.call(exchange_params)
    SaveExchange.call(exchange: exchange)
    head :ok
  end

  def simulate
    exchange = SimulateExchange.call(exchange_params)
    render json: { fair: CheckFairness.call(exchange: exchange) }
  end

  private

  def exchange_params
    params.permit(left: [], right: [])
  end
end
