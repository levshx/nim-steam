import steam 

 # input you Key Steam Web API
let clientSteam = newSteamClient("XXXXXXBBBBBBBBBBKKKKKKKKKIIIII") 
echo clientSteam.keyAPI
echo clientSteam.getServerInfo()
echo clientSteam.getMinItem(730, 1, "★ Karambit | Doppler (Factory New)")
echo clientSteam.tradeHistory(1)
