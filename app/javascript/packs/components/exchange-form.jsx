import React, { useEffect, useState } from 'react'
import _ from "lodash";
import ExchangeSide from "./exchange-side";

export default function ExchangeForm() {
  const [allPokemons, setAllPokemons] = useState([]);
  const [leftPokemons, setLeftPokemons] = useState(_.times(6, () => {}));
  const [rightPokemons, setRightPokemons] = useState(_.times(6, () => {}));

  useEffect(() => {
    fetch("/pokemons")
    .then((response) => {
      return response.json();
    }).then(pokemons => {
      setAllPokemons(pokemons);
    });
  }, []);

  return (
    <>
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
