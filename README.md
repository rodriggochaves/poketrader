# README

This is the Pokemon Trader calculator! Given a pair of trade, each with one to six
pokemons, it says if was a fair or unfair trade, based on base experience status.

## How the code is organized here.

Core of application resides:

- We have `app/services` to handle domain transactions.
- We have `app/models` to abstract the domain entities.
- We have `app/controllers` to handle web requests.
- We have `app/javascript/poke-trader-app`. It is a React component to deliver a good experience when simulating
  new exchanges.

## Web - Pages

You can access three main pages:

- `/exchanges/new` is a React component to help simulate and persist new trades.
- `/pokemons/new` is a page to fetch pokemons not registered yet.
- `/exchanges` is a history page, showing every exchanges persisted.

## HTTP API

You can access these endpoints:

- `GET /pokemons` to return all pokemons persisted
- `GET /exchanges` to return all exchanges, as history
- `POST /exchanges` to persiste new trades
- `POST /exchanges/simulate` to check if a trade is fair or not

## Entities

This system was built on top of three main entities:

1. `Pokemons` is the pokemons themselves. We record the name and base experience here.
2. `Exchange` is a record of a trade.
3. `ExchangedPokemon` is a record of a single pokemon inside a trade. An `Exchange`
   is composed by many `ExchangedPokemons` and it can be `left` or `right` side.
