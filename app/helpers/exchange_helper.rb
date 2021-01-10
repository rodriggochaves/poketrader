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
      <div class="card-footer text-white bg-success">
        Fair trade
      </div>
    ).html_safe
  end

  def unfair_card_footer
    %(
      <div class="card-footer text-white bg-warning">
        Unfair trade
      </div>
    ).html_safe
  end
end
