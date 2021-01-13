import React from "react";
import ReactDOM from "react-dom";
import ExchangeForm from "./components/exchange-form";

function PokeTraderAPP() {
  return (
    <div className="container">
      <h1 className="display-2">PokeTrader</h1>
      <br />

      <div className="card">
        <div className="card-body bg-light">
          If a pokemon is missing from the list, you can add it on "Pokemons"
          menu.
        </div>
      </div>
      <br />

      <ExchangeForm />
    </div>
  );
}

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <PokeTraderAPP />,
    document.querySelector("#poke-trader-app")
  );
});
