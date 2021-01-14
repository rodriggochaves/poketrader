import { useEffect, useState } from "react";
import { postFairness } from "./api";

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
