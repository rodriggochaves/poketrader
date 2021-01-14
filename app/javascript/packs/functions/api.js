export async function searchPokemons(query) {
  const params = new URLSearchParams({ query });
  const response = await fetch(`/pokemons?${params.toString()}`);
  return response.json();
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
