import React, { useState } from "react";

import ExchangeInput from "./exchange-input";
import { searchPokemons } from "../functions/api";

export default function ExchangeSide({ pokemons, addPokemon, side }) {
  const [pokemonOptions, setPokemonOptions] = useState([]);

  function addPokemonToSide(pokemon, index) {
    const newPokemons = _.clone(pokemons);
    newPokemons[index] = pokemon;
    addPokemon(newPokemons);
  }

  async function searchOnIndex(query, index) {
    const pokemonResponse = await searchPokemons(query);
    setPokemonOptions(pokemonResponse);
    addPokemonToSide(pokemonResponse[0], index);
  }

  return pokemons.map((pokemon, index) => {
    return (
      <ExchangeInput
        key={`${side}-${index}`}
        pokemon={pokemon}
        pokemonsOptions={pokemonOptions}
        sideKey={`${side}-${index}`}
        onSearch={(query) => searchOnIndex(query, index)}
      />
    );
  });
}
