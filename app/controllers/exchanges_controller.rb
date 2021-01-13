class ExchangesController < ApplicationController
  def new; end

  def index
    @exchanges = ExchangeHistory.new.call
  end

  def create
    exchange = SimulateExchange.new(exchange_params).call
    exchange.save!
    head :ok
  end

  def simulate
    exchange = SimulateExchange.new(exchange_params).call
    render json: { fair: exchange.fair? }
  end

  private

  def exchange_params
    params.permit(left: [], right: [])
  end

  def fairness_message
    if @exchange.fair?
      { notice: "Pokemons successfully exchanged\nIt was a fair trade!" }
    else
      { alert: "Pokemons successfully exchanged\nIt wasn't a fair trade!" }
    end
  end
end
