[![nimble](https://raw.githubusercontent.com/levshx/nim-steam/main/resources/nim-steam.png)](https://github.com/levshx/nim-steam)

[![NOT COMPLETE](https://img.shields.io/static/v1?label=Attention&message=Project%20in%20development&color=red)](https://github.com/levshx/nim-steam)

# nim-steam 

compile with param: -d:ssl

### See more
[Steam nim docs](https://levshx.github.io/nim-doc/steam/steam.html)

```nim
import steam 

 # input you Key Steam Web API https://steamcommunity.com/dev/apikey
 # use var for reset options
var clientSteam = newSteamClient("XXXXXXBBBBBBBBBBKKKKKKKKKIIIII") 

```

Procs
```nim
proc newSteamClient(keyWebAPI: string): SteamClient {...}

proc getServerInfo(client: SteamClient): ServerInfo {...}
proc getMinItem(client: SteamClient; appid: int; vallet: int;
                market_hash_name: string): MinItem {...}
proc tradeHistory(client: SteamClient; max_trades: int): seq[Trade] {...}
proc getAssetMarketIconURL(client: SteamClient; icon_code: string): string {...}
proc getProfileInventory(client: SteamClient; steamID64: int64; gameID: int;
                         valueWTF: int): seq[InventoryAsset] {...}
proc getAssetClassInfo(client: SteamClient; gameID: int; classid: int64): AssetClassInfo {...}
proc getOwnedGames(client: SteamClient; steamID64: int64): OwnedGames {...}
proc getGameAssetPrices(client: SteamClient; gameID: int): seq[GameAssetPrice] {...}
```
Example methods in [Steam nim docs](https://levshx.github.io/nim-doc/steam/steam.html)
