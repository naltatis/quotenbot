rest = require 'restler'

class OpenLigaDB
  url: "http://openligadb-json.heroku.com/api/matchdata_by_group_league_saison"
  constructor: ->
  games: (season, group, cb) ->
    query =
      group_order_id: group
      league_saison: season
      league_shortcut: 'bl1'
    rest.get(@url, query: query).on 'complete', (data) ->
      cb null, data.matchdata

(exports ? this).OpenLigaDB = OpenLigaDB