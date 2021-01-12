import { useEffect, useState, useRef } from 'react'
import { getAllPokemons, postFairness } from "./api";

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

export function useFairnessEffect(left, right, setFair) {
  const initialRender = useRef(true);

  useEffect(() => {
    if (initialRender.current) {
      initialRender.current = false;
    } else {
      postFairness(pokemons(left), pokemons(right), setFair);
    }
  }, [
    pokemons(left).length,
    pokemons(right).length
  ]);
}
