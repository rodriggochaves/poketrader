import React from "react";
import { screen, render } from "@testing-library/react";
import "@testing-library/jest-dom/extend-expect";

import ExchangeForm from "packs/components/exchange-form";

describe("ExchangeForm", () => {
  it("renders the left side", () => {
    render(<ExchangeForm />);
    expect(screen.getByText(/Left/)).toBeInTheDocument();
  });

  it("renders the right side", () => {
    render(<ExchangeForm />);
    expect(screen.getByText(/Right/)).toBeInTheDocument();
  });

  it("renders twelve inputs to search pokemons", () => {
    render(<ExchangeForm />);
    expect(screen.getAllByText(/Base experience/).length).toEqual(12);
  });
});
