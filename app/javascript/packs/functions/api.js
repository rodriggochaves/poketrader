export async function searchPokemons(query) {
  const params = new URLSearchParams({ query });
  const response = await fetch(`/pokemons?${params.toString()}`);
  return response.json();
}

function post(url, body) {
  return fetch(url, {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  });
}

export async function postExchange(leftPokemons, rightPokemons) {
  await post("/exchanges", {
    left: leftPokemons,
    right: rightPokemons,
  });
}

export async function postFairness(leftPokemons, rightPokemons) {
  const response = await post("/exchanges/simulate", {
    left: leftPokemons,
    right: rightPokemons,
  });

  return response.json();
}
