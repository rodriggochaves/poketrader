import React, { useState } from "react";
import { AsyncTypeahead } from "react-bootstrap-typeahead";
import { searchPokemons } from "../functions/api";

function renderBaseExperience(pokemon) {
  if (pokemon?.base_experience) {
    return pokemon.base_experience;
  } else {
    return 0;
  }
}

export default function ExchangeInput({ inputId, addPokemon }) {
  const [isLoading, setLoading] = useState(false);
  const [pokemons, setPokemons] = useState([]);
  const [selectedPokemon, setSelectedPokemon] = useState(null);

  async function handleSearch(query) {
    setLoading(true);
    const pokemonResponse = await searchPokemons(query);
    setPokemons(pokemonResponse);
    setLoading(false);
  }

  function onChange(pokemons) {
    setSelectedPokemon(pokemons[0]);
    addPokemon(pokemons[0]);
  }

  return (
    <>
      <AsyncTypeahead
        id={inputId}
        filterBy={() => true}
        labelKey={(option) => option.name}
        options={pokemons}
        onSearch={handleSearch}
        onChange={onChange}
        minLength={3}
      >
        {() => (
          <div className="rbt-aux">
            {isLoading && (
              <div class="spinner-border spinner-border-sm" role="status">
                <span class="visually-hidden">Loading...</span>
              </div>
            )}
          </div>
        )}
      </AsyncTypeahead>
      <p>Base experience: {renderBaseExperience(selectedPokemon)}</p>
    </>
  );
}
