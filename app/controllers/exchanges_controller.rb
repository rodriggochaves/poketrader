class ExchangesController < ApplicationController
  def new; end

  def index
    @exchanges = ExchangeHistory.call
  end

  def create
    exchange = SimulateExchange.call(exchange_params)
    exchange.save!
    head :ok
  end

  def simulate
    exchange = SimulateExchange.call(exchange_params)
    render json: { fair: exchange.fair? }
  end

  private

  def exchange_params
    params.permit(left: [], right: [])
  end
end
