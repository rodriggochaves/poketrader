class AddPokeIndexToPokemon < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :poke_index, :integer
  end
end
