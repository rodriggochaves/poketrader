import React from "react";
import { screen, render } from "@testing-library/react";
import "@testing-library/jest-dom/extend-expect";

import ExchangeSide from "packs/components/exchange-side";

describe("ExchangeInput", () => {
  it("renders", () => {
    const pokemons = [{ name: "squirtle", base_experience: 62 }];
    render(
      <ExchangeSide pokemons={pokemons} addPokemon={jest.fn()} side="left" />
    );
    expect(screen.getByText(/Base experience/)).toBeInTheDocument();
  });
});
