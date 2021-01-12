import React, { useEffect, useState } from 'react'
import _ from "lodash";
import ExchangeInput from "./exchange-input";

export default function ExchangeSide({
  allPokemons,
  setPokemons,
  pokemons,
  side
}) {

  function addPokemonToExchange(pokemon, index) {
    pokemons[index] = pokemon;
    setPokemons(pokemons);
  }

  return pokemons.map((_pokemon, index) => {
      return (
        <ExchangeInput
          key={`${side}-${index}`}
          sideKey={`${side}-${index}`}
          allPokemons={allPokemons}
          pushPokemon={(pokemon) => addPokemonToExchange(pokemon, index)}
        />
      )
    })
}
