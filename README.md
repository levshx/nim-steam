# Steam lib

how to use
```nim
import steam 

 # input you Key Steam Web API https://steamcommunity.com/dev/apikey
 # use var for reset options
var clientSteam = newSteamClient("XXXXXXBBBBBBBBBBKKKKKKKKKIIIII") 
```
Get/Reset Steam Web API
```nim
let key = clientSteam.keyAPI    # GET
clientSteam.keyAPI = "ASDF..."  # RESET
```
Steam get server info
```nim 
let info = clientSteam.getServerInfo()

#output:
( 
  servertime: 1623586146, 
  servertimestring: "Sun Jun 13 05:09:06 2021"
)
```
Get minimal view of Market Item
```nim
let gameID = 730 #CS:GO
let valletID = 1 #USD
let hash_name = "★ Karambit | Doppler (Factory New)"
echo clientSteam.getMinItem(gameID, valletID, hash_name)

#output:
(
  success: true, 
  lowest_price: "$798.99", 
  volume: "9", 
  median_price: "$748.26"
)
```
