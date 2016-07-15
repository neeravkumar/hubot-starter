module.exports = (robot) ->
  robot.respond /(\d+\.?\d*) sgd to (.*)/i, (msg) ->
    amount = parseFloat(msg.match[1])
    dest_currency = msg.match[2].toUpperCase()

    msg.http("http://api.fixer.io/latest")
      .query
        base : "SGD"
        symbols: dest_currency
      .get() (err, res, body) ->
        rate = JSON.parse(body).rates[dest_currency]
        if !err && rate
          amount_dest = amount * rate
          msg.send "#{amount} SGD is #{amount_dest.toFixed(2)} #{dest_currency}."
        else
          msg.send "Sorry, the API is down or you have entered a bad currency"

