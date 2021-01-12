import React from 'react'

function fairExchange() {
  return (
    <div className="alert alert-success" role="alert">
      This exchange is fair!
    </div>
  )
}

function unfairExchange() {
  return (
    <div className="alert alert-warning" role="alert">
      This exchange is unfair!
    </div>
  )
}

export default function ExchangeFairness({ fair }) {
  if (typeof fair === "undefined") {
    return null;
  } else if (fair) {
    return fairExchange();
  } else {
    return unfairExchange();
  }
}
