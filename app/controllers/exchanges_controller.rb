class ExchangesController < ApplicationController
  def new; end

  def index; end

  def create
    @exchange = CreateExchange.new(exchange_params).call
    redirect_to new_exchange_path, fairness_message
  rescue FindOrFetchPokemon::PokemonNotFound => exception
    redirect_to new_exchange_path, flash: { error: exception.message }
  rescue StandardError
    redirect_to new_exchange_path, flash: { error: "Unknown Error! Try again later!" }
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
