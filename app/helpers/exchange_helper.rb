module ExchangeHelper
  def fairness_footer(exchange)
    if exchange.fair?
      fair_card_footer
    else
      unfair_card_footer
    end
  end

  def fair_card_footer
    %(
      <div class="card-footer text-primary bg-light">
        <b>Fair trade</b>
      </div>
    ).html_safe
  end

  def unfair_card_footer
    %(
      <div class="card-footer text-warning bg-light">
        <b>Unfair trade</b>
      </div>
    ).html_safe
  end
end
