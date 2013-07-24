rest = require 'restler'

class Botliga
  url: 'http://www.botliga.de/api/guess'
  constructor: (@token) ->
  post: (match_id, result, cb) ->
    data =
      match_id: match_id
      result: result
      token: @token
    rest.post(@url, data: data)
      .on('success', (data) -> cb(data))
      .on('error', (err) -> cb(err))

(exports ? this).Botliga = Botliga