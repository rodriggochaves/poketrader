import React from "react";

import ExchangeInput from "./exchange-input";

export default function ExchangeSide({ pokemons, addPokemon, side }) {
  function addPokemonToSide(pokemon, index) {
    const newPokemons = _.clone(pokemons);
    newPokemons[index] = pokemon;
    addPokemon(newPokemons);
  }

  return pokemons.map((_pokemon, index) => {
    return (
      <ExchangeInput
        key={`${side}-${index}`}
        inputId={`${side}-${index}`}
        addPokemon={(pokemon) => addPokemonToSide(pokemon, index)}
      />
    );
  });
}
