import React, { useState } from 'react'
import { Typeahead } from "react-bootstrap-typeahead";

export default function ExchangeInput({
  sideKey,
  allPokemons = [],
  pushPokemon
}) {
  const [pokemon, setPokemon] = useState({});

  function selectPokemon(pokemonArray) {
    const pokemon = pokemonArray[0];
    setPokemon(pokemon);
    pushPokemon(pokemon);
  }

  function renderBaseExperience(pokemon) {
    if(pokemon?.base_experience) {
      return pokemon.base_experience
    } else {
      return "-"
    }
  }

  return (
    <>
      <Typeahead
        id={sideKey}
        labelKey={(option) => option.name}
        options={allPokemons}
        onChange={selectPokemon}
      />
      <p>Base experience: {renderBaseExperience(pokemon)}</p>
    </>
  )
}
