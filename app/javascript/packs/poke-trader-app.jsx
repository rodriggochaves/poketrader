import React from "react";
import ReactDOM from "react-dom";
import ExchangeForm from "./components/exchange-form";

function PokeTraderAPP() {
  return (
    <div className="container">
      <h1 className="display-2 mb-2">PokeTrader</h1>

      <div className="card  mb-2">
        <div className="card-body bg-light">
          If a pokemon is missing from the list, you can add it on "Pokemons"
          menu.
        </div>
      </div>

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
