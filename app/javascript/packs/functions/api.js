export async function getAllPokemons(setPokemons) {
  const response = await fetch("/pokemons")
  const pokemons = await response.json();

  setPokemons(pokemons);
}

function pokemonName(pokemon) {
  return pokemon.name
}

export async function postFairness(leftPokemons, rightPokemons, setFair){
  const response = await fetch("/exchanges/simulate", {
    method: "POST",
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      left:leftPokemons.map(pokemonName),
      right: rightPokemons.map(pokemonName)
    })
  })
  const { fair } = await response.json();

  setFair(fair);
}
