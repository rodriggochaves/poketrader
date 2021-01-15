import React from "react";
import { screen, render, fireEvent } from "@testing-library/react";
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

  it("sends a request to /exchanges when submitting", () => {
    const mockFetch = jest.fn();
    window.fetch = mockFetch;
    window.alert = jest.fn();

    render(<ExchangeForm />);
    fireEvent.click(screen.getByText(/submit/i));
    expect(mockFetch).toHaveBeenCalled();
  });
});
