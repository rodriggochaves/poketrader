import { useEffect, useState, useRef } from 'react'
import { getAllPokemons, postFairness } from "./api";

export function usePokemons() {
  const [allPokemons, setAllPokemons] = useState();

  useEffect(() => {
    getAllPokemons(setAllPokemons)
  }, []);

  return allPokemons;
}

export function useFairness(leftPokemons, rightPokemons) {
  const [fair, setFair] = useState(undefined);

  useEffect(() => {
    if (leftPokemons.length > 0 && rightPokemons.length > 0) {
      postFairness(leftPokemons, rightPokemons, setFair);
    }
  }, [
    leftPokemons.length,
    rightPokemons.length
  ]);

  return [fair, setFair];
}
