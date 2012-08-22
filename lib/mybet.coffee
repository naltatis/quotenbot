jsdom  = require 'jsdom'

class MyBet
  url: "http://www.mybet.com/de/sportwetten/wettprogramm/fussball/deutschland/1-bundesliga"
  teams:
    'Borussia Dortmund': '7'
    'Hamburger SV': '100'
    'FC Augsburg': '95'
    'SC Freiburg': '112'
    'Hannover 96': '55'
    'TSG Hoffenheim': '123'
    'SV Werder Bremen': '134'
    '1. FC Kaiserslautern': '76'
    'VfB Stuttgart': '16'
    'FC Schalke 04': '9'
    '1. FC Köln': '65'
    'VfL Wolfsburg': '131'
    'Hertha BSC Berlin': '54'
    '1. FC Nürnberg': '79'
    'Mainz 05': '81'
    'Bayer Leverkusen': '6'
    'FC Bayern München': '40'
    'Borussia Mönchengladbach': '87'
    'Eintracht Frankfurt': '91'
    'Greuther Fürth': '115'
    'Fortuna Düsseldorf': '185'
  constructor: ->
  load: (cb) ->
    self = @
    jsdom.env @url, ['http://code.jquery.com/jquery-1.6.2.js'], (err, window) ->
      $ = window.$
      games = $('table.betEvent')
      data = []
      $.each games, ->
        entry = self._entry $(@)
        data.push entry
      cb err, data
  _entry: (game) ->
    entry = 
      home: game.find(".home1x2 a").attr("title")
      guest: game.find(".away1x2 a").attr("title")
      odds:
        home: parseFloat game.find(".home1x2 a").text()
        draw: parseFloat game.find(".draw1x2 a").text()
        guest: parseFloat game.find(".away1x2 a").text()
    console.error("could not find " + entry.home) unless @teams[entry.home]
    console.error("could not find " + entry.guest) unless @teams[entry.guest]
    entry.home_id = @teams[entry.home]
    entry.guest_id = @teams[entry.guest]
    entry
    
(exports ? this).MyBet = MyBet