class AddTradeToExchangedPokemons < ActiveRecord::Migration[6.1]
  def change
    add_reference :exchanged_pokemons, :exchange, null: false, foreign_key: true
  end
end
