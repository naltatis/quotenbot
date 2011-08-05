MyBet = require("./lib/mybet").MyBet

mybet = new MyBet()
mybet.load (err, data) ->
  console.log err, data
  