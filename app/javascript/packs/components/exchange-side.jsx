import React from "react";
import ExchangeInput from "./exchange-input";

export default function ExchangeSide({
  allPokemons,
  pokemons,
  setPokemons,
  side,
}) {
  function addPokemonToExchange(pokemon, index) {
    const newPokemons = _.clone(pokemons);
    newPokemons[index] = pokemon;
    setPokemons(newPokemons);
  }

  return pokemons.map((pokemon, index) => {
    return (
      <ExchangeInput
        key={`${side}-${index}`}
        sideKey={`${side}-${index}`}
        allPokemons={allPokemons}
        pushPokemon={(newPokemon) => addPokemonToExchange(newPokemon, index)}
        pokemon={pokemon}
      />
    );
  });
}
