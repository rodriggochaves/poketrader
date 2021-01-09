class ExchangesController < ApplicationController
  def new
  end

  def index
  end

  def create
    CreateExchange.new(exchange_params).call
    head :ok
  end

  private
  def exchange_params
    params.permit(left: [], right: [])
  end
end
