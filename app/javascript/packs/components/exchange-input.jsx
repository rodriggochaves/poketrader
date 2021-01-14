import React, { useState } from "react";
import { AsyncTypeahead } from "react-bootstrap-typeahead";

export default function ExchangeInput({
  pokemon,
  pokemonsOptions = [],
  sideKey,
  updatePokemon,
}) {
  const [isLoading, setLoading] = useState(false);
  const [selectedPokemons, setSelectedPokemons] = useState([]);

  function renderBaseExperience(pokemon) {
    if (pokemon?.base_experience) {
      return pokemon.base_experience;
    } else {
      return 0;
    }
  }

  async function handleSearch(query) {
    setLoading(true);
    await updatePokemon(query);
    setLoading(false);
  }

  if (pokemon?.name === "" && selectedPokemons.length > 0) {
    setSelectedPokemons([]);
  }

  return (
    <>
      <AsyncTypeahead
        id={sideKey}
        isLoading={isLoading}
        filterBy={() => true}
        labelKey={(option) => option.name}
        options={pokemonsOptions}
        onChange={setSelectedPokemons}
        selected={selectedPokemons}
        onSearch={handleSearch}
        minLength={2}
      />
      <p>Base experience: {renderBaseExperience(selectedPokemons[0])}</p>
    </>
  );
}
