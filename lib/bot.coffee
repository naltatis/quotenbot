class Bot
  constructor: (@odds) ->
  guess: (game) ->
    odd = @_find_odds game.id_team1, game.id_team2
    result = @_predict odd
  _predict: (odd) ->
    if not odd?
      console.log "no odds found fallin back to 2:1"
      return '2:1'
    odds = odd.odds
    diff = odds.home - odds.guest
    if odds.draw - 1 <= odds.home && odds.draw - 1 <= odds.guest
      return '1:1'
    else if diff < -4
      return '3:0'
    else if diff < -2
      return '2:0'
    else if diff < 0
      return '2:1'
    else if diff < 1
      return '0:1'
    else if diff < 3
      return '0:2'
    else
      return '0:3'

  _find_odds: (home_id, guest_id) ->
    for odd in @odds
      return odd if odd.home_id == home_id && odd.guest_id == guest_id

(exports ? this).Bot = Bot