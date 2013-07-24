rest = require 'restler'

class OpenLigaDB
  constructor: ->
  games: (season, group, cb) ->
    url = "http://openligadb-json.heroku.com/api/matchdata_by_group_league_saison"
    query =
      group_order_id: group
      league_saison: season
      league_shortcut: 'bl1'
    rest.get(url, query: query).on 'success', (data) ->
      cb null, data.matchdata

  currentGroup: (cb) ->
    url = "http://openligadb-json.heroku.com/api/current_group"
    query =
      league_shortcut: 'bl1'
    rest.get(url, query: query).on 'success', (data) ->
      cb null, parseInt(data.group_order_id)


(exports ? this).OpenLigaDB = OpenLigaDB