import React from "react";
import { render } from "@testing-library/react";

import ExchangeInput from "packs/components/exchange-input";

describe("ExchangeInput", () => {
  it("renders", () => {
    render(<ExchangeInput inputId="left-1" addPokemon={jest.fn()} />);
  });
});
