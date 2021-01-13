import React, { useState } from "react";
import _ from "lodash";

import ExchangeSide from "./exchange-side";
import ExchangeFairness from "./exchange-fairness-alert";
import { usePokemons, useFairness } from "../functions/pokemons";
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
  const allPokemons = usePokemons();
  const [leftSide, setLeftSide] = useState(initialPokemonSlots());
  const [rightSide, setRightSide] = useState(initialPokemonSlots());

  const leftPokemons = pokemons(leftSide);
  const rightPokemons = pokemons(rightSide);

  const [fair, setFair] = useFairness(leftPokemons, rightPokemons);

  async function submitForm() {
    await postExchange(leftPokemons, rightPokemons);
    alert("Exchange registered");
    setFair(undefined);
    setLeftSide(initialPokemonSlots());
    setRightSide(initialPokemonSlots());
  }

  return (
    <>
      <div className="row">
        <div className="col">
          <ExchangeFairness fair={fair} />
        </div>
      </div>
      <div className="row">
        <div className="col">
          <label htmlFor="left" className="form-label">
            Left side
          </label>
          <ExchangeSide
            allPokemons={allPokemons}
            pokemons={leftSide}
            setPokemons={setLeftSide}
            side="left"
          />
        </div>
        <div className="col">
          <label htmlFor="right" className="form-label">
            Right side
          </label>
          <ExchangeSide
            allPokemons={allPokemons}
            pokemons={rightSide}
            setPokemons={setRightSide}
            side="right"
          />
        </div>
      </div>

      <br />
      <button className="btn btn-primary" onClick={submitForm}>
        Submit trade!
      </button>
    </>
  );
}
