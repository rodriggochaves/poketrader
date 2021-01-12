import React, { useState } from "react"
import _ from "lodash";

import ExchangeSide from "./exchange-side";
import ExchangeFairness from "./exchange-fairness-alert";
import { usePokemons, useFairnessEffect } from "../functions/pokemons";

export default function ExchangeForm() {
  const allPokemons = usePokemons();
  const [leftPokemons, setLeftPokemons] = useState(_.times(6, () => null));
  const [rightPokemons, setRightPokemons] = useState(_.times(6, () => null));
  const [fair, setFair] = useState(undefined);

  useFairnessEffect(leftPokemons, rightPokemons, setFair);

  return (
    <>
      <div className="row">
        <div className="col">
          <ExchangeFairness fair={fair} />
        </div>
      </div>
      <div className="row">
        <div className="col">
          <label htmlFor="left" className="form-label">Left side</label>
          <ExchangeSide
            allPokemons={allPokemons}
            pokemons={leftPokemons}
            setPokemons={setLeftPokemons}
            side="left"
          />
        </div>
        <div className="col">
          <label htmlFor="right" className="form-label">Right side</label>
          <ExchangeSide
            allPokemons={allPokemons}
            pokemons={rightPokemons}
            setPokemons={setRightPokemons}
            side="right"
          />
        </div>
      </div>

      <br/>
      <button className="btn btn-primary">Submit trade!</button>
    </>
  )
}
