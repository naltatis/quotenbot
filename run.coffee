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
  bot = new Bot odds
  for game in games
    result = bot.guess game
    console.log "posting result #{result} for match #{game.match_id}"
    botliga.post game.match_id, result, (err, data) ->
      console.log "done", err

mybet.load (err, odds) ->
  console.log "loaded odds from mybet"
  openliga.games 2012, 1, (err, games) ->
    console.log "loaded matches for 4/2011"
    guess games, odds