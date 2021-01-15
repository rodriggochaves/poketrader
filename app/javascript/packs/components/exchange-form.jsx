import React, { useState } from "react";
import _ from "lodash";

import ExchangeSide from "./exchange-side";
import ExchangeFairness from "./exchange-fairness-alert";
import { useFairness } from "../functions/pokemons";
import { postExchange } from "../functions/api";

function pokemons(side) {
  return side
    .filter((pokemon) => !!pokemon?.name)
    .map((pokemon) => pokemon.name);
}

function initialPokemonSlots() {
  return _.clone(_.times(6, () => ({ name: "" })));
}

export default function ExchangeForm() {
  const [leftSide, setLeftSide] = useState(initialPokemonSlots());
  const [rightSide, setRightSide] = useState(initialPokemonSlots());

  const leftPokemons = pokemons(leftSide);
  const rightPokemons = pokemons(rightSide);

  const [fair, setFair] = useFairness(leftPokemons, rightPokemons);

  async function submitForm() {
    try {
      await postExchange(leftPokemons, rightPokemons);
      alert("Exchange registered successfully");
    } catch (error) {
      alert("Error when registering exchange");
    }
  }

  return (
    <>
      <div className="row mb-2">
        <div className="col">
          <ExchangeFairness fair={fair} />
        </div>
      </div>
      <div className="row">
        <div className="col">
          <label htmlFor="left" className="form-label">
            <strong>Left side</strong>
          </label>
          <ExchangeSide
            pokemons={leftSide}
            addPokemon={setLeftSide}
            side="left"
          />
        </div>
        <div className="col">
          <label htmlFor="right" className="form-label">
            <strong>Right side</strong>
          </label>
          <ExchangeSide
            pokemons={rightSide}
            addPokemon={setRightSide}
            side="right"
          />
        </div>
      </div>

      <button className="btn btn-primary" onClick={submitForm}>
        Submit trade!
      </button>
    </>
  );
}
