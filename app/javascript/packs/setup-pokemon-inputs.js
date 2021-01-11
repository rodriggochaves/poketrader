import $ from "jquery"

function addNewPokemonInput(event) {
  const container = $(event.currentTarget).siblings(".input-container");

  if (hasLessThanSixPokemons(container)) {
    cloneInput(container);
  }

  if (shouldHideNewInputButton(container)) {
    $(event.currentTarget).hide();
  }
}

function cloneInput(container) {
  const newInput = container.children("input").first().clone();
  newInput.val("");
  container.append(newInput);
}

function countInputs(container) {
  return container.children("input").length;
}

function hasLessThanSixPokemons(container) {
  return countInputs(container) <= 6
}

function shouldHideNewInputButton(container) {
  return countInputs(container) >= 6
}

export default function setupPokemonInputs() {
  $(".add-new-pokemon").on("click", (event) => {
    event.preventDefault();
    addNewPokemonInput(event);
  })
}
