import steam 

 # input you Key Steam Web API
let clientSteam = newSteamClient("XXXXXXBBBBBBBBBBKKKKKKKKKIIIII") 

echo clientSteam.keyAPI

echo clientSteam.getServerInfo()

echo clientSteam.getMinItem(730, 1, "★ Karambit | Doppler (Factory New)")

echo clientSteam.tradeHistory(1)

echo clientSteam.getAssetMarketIconURL("-9a81dlWLwJ2UUGcVs_nsVtzdOEdtWwKGZZLQHTxDZ7I56KU0Zwwo4NUX4oFJZEHLbXU5A1PIYQNqhpOSV-fRPasw8rsUFJ5KBFZv668FFUxnaPLJz5H74y1xtTcz6etNumIx29U6Zd3j7yQoYih3lG1-UJqY27xJIeLMlhpaD9Aclo")

echo clientSteam.getProfileInventory(76561198082780051,730,2)
