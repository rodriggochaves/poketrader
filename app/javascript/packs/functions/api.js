export async function getAllPokemons(setPokemons) {
  const response = await fetch("/pokemons")
  const pokemons = await response.json();

  setPokemons(pokemons);
}
