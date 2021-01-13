import React, { useState } from 'react'
import { Typeahead } from "react-bootstrap-typeahead";

export default function ExchangeInput({
  sideKey,
  allPokemons = [],
  pushPokemon,
  pokemon,
}) {
  const [currentPokemon, setCurrentPokemon] = useState([])

  function selectPokemon(pokemonArray) {
    setCurrentPokemon(pokemonArray);

    const pokemon = pokemonArray[0];
    pushPokemon(pokemon);
  }

  function renderBaseExperience(pokemon) {
    if(pokemon?.base_experience) {
      return pokemon.base_experience
    } else {
      return "-"
    }
  }

  if (pokemon?.name === "" && currentPokemon.length > 0) {
    setCurrentPokemon([])
  }

  return (
    <>
      <Typeahead
        id={sideKey}
        labelKey={(option) => option.name}
        options={allPokemons}
        onChange={selectPokemon}
        selected={currentPokemon}
      />
      <p>Base experience: {renderBaseExperience(pokemon)}</p>
    </>
  )
}
