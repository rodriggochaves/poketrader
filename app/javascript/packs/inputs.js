import $ from "jquery"

export default class ExchangeInputs {
  static start() {

    $(".add-new-pokemon").on("click", (event) => {
      event.preventDefault();

      const container = $(event.target).siblings(".input-container");
      let newInput;
      if (container.children("input").length <= 6) {
        newInput = container.children("input").first().clone();
        container.append(newInput);
      }

      if (container.children("input").length >= 6) {
        $(event.target).hide();
      }
    })
  }
}


