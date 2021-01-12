import { useEffect, useState, useRef } from 'react'
import { getAllPokemons } from "./api";

export function usePokemons() {
  const [allPokemons, setAllPokemons] = useState();

  useEffect(() => {
    getAllPokemons(setAllPokemons)
  }, []);

  return allPokemons;
}

function pokemons(side) {
  return side.filter(pokemon => pokemon);
}

function pokemonName(pokemon) {
  return pokemon.name
}

export function useFairnessEffect(left, right, setFair) {
  const initialRender = useRef(true);

  useEffect(() => {
    const checkFairness = async () => {
      const response = await fetch("/exchanges/simulate", {
        method: "POST",
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ left:pokemons(left).map(pokemonName), right: pokemons(right).map(pokemonName)})
      })
      const { fair } = await response.json();
      setFair(fair);
    }

    if (initialRender.current) {
      initialRender.current = false;
    } else {
      checkFairness();
    }
  }, [
    pokemons(left).length,
    pokemons(right).length
  ]);
}
