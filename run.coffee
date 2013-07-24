MyBet = require("./lib/mybet").MyBet
OpenLigaDB = require("./lib/openligadb").OpenLigaDB
Bot = require("./lib/bot").Bot
Botliga = require("./lib/botliga").Botliga

token = process.argv[2]
return console.log 'token argument missing' if not token?


mybet = new MyBet()
openliga = new OpenLigaDB()
botliga = new Botliga token
guess = (games, odds) ->
  bot = new Bot(odds)
  for game in games
    result = bot.guess game
    console.log "posting result #{result} for #{game.name_team1} vs. #{game.name_team2} (#{game.match_id})"
    botliga.post game.match_id, result, (err, data) ->
      console.log err if err

mybet.load (err, odds) ->
  console.log "loaded odds from mybet"
  year = 2013
  openliga.currentGroup (err, group) ->
    openliga.games year, group, (err, games) ->
      console.log "loaded matches for #{group}/#{year}"
      guess games, odds