import React, { useState } from "react";
import ExchangeInput from "./exchange-input";

export default function ExchangeSide({
  allPokemons,
  pokemons,
  addPokemonToExchangeSide,
  side,
}) {
  const [pokemonOptions, setPokemonOptions] = useState([]);

  function addPokemonToExchange(pokemon, index) {
    const newPokemons = _.clone(pokemons);
    newPokemons[index] = pokemon;
    addPokemonToExchangeSide(newPokemons);
  }

  async function updatePokemon(query, index) {
    const params = new URLSearchParams({ query });
    const response = await fetch(`/pokemons?${params.toString()}`);
    const pokemonsResponse = await response.json();

    setPokemonOptions(pokemonsResponse);
    addPokemonToExchange(pokemonsResponse[0], index);
  }

  return pokemons.map((pokemon, index) => {
    return (
      <ExchangeInput
        key={`${side}-${index}`}
        pokemonsOptions={pokemonOptions}
        pokemon={pokemon}
        sideKey={`${side}-${index}`}
        updatePokemon={(query) => updatePokemon(query, index)}
        onChange={(pokemons) => addPokemonToExchange(pokemons[0], index)}
      />
    );
  });
}
