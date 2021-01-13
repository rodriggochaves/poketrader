import { useEffect, useState, useRef } from "react";
import { getAllPokemons, postFairness } from "./api";

export function usePokemons() {
  const [allPokemons, setAllPokemons] = useState();

  useEffect(() => {
    getAllPokemons(setAllPokemons);
  }, []);

  return allPokemons;
}

function shouldUpdateFairness(leftPokemons, rightPokemons) {
  return leftPokemons.length > 0 && rightPokemons.length > 0;
}

export function useFairness(leftPokemons, rightPokemons) {
  const [fair, setFair] = useState(undefined);

  useEffect(() => {
    async function updateFairness(leftPokemons, rightPokemons) {
      if (shouldUpdateFairness(leftPokemons, rightPokemons)) {
        const { fair } = await postFairness(leftPokemons, rightPokemons);
        setFair(fair);
      }
    }

    updateFairness(leftPokemons, rightPokemons);
  }, [leftPokemons.length, rightPokemons.length]);

  return [fair, setFair];
}
