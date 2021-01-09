class ExchangesController < ApplicationController
  def new
  end

  def index
  end

  def create
    CreateExchange.new(exchange_params).call
    redirect_to new_exchange_path, notice: "Your Pokemons was sent successfully"
  end

  private
  def exchange_params
    params.permit(left: [], right: [])
  end
end
