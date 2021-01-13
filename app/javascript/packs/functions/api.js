export async function getAllPokemons(setPokemons) {
  const response = await fetch("/pokemons");
  const pokemons = await response.json();

  setPokemons(pokemons);
}

export async function postExchange(leftPokemons, rightPokemons) {
  await fetch("/exchanges", {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      left: leftPokemons,
      right: rightPokemons,
    }),
  });
}

export async function postFairness(leftPokemons, rightPokemons) {
  const response = await fetch("/exchanges/simulate", {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      left: leftPokemons,
      right: rightPokemons,
    }),
  });

  return response.json();
}
