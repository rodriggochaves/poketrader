class CreateExchangedPokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :exchanged_pokemons do |t|
      t.integer :side
      t.references :pokemon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
