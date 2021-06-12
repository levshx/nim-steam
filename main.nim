import json, httpclient, strutils
# for compile use -d:ssl

# STEAM Web API Key
var steamWebAPIKey = readFile("SteamApiKey.txt")



var client = newHttpClient()

# Decode specific chars to % in URL
proc escapeLink(s: string): string =
  result = newStringOfCap(s.len + s.len shr 2)
  for c in items(s):
    case c
    of 'a'..'z', '_', 'A'..'Z', '0'..'9', '.', '#', ',', '/':
      result.add c
    else:
      add(result, "%")
      add(result, toHex(ord(c), 2))


type
  MinItem = object
    success: bool
    lowest_price: string
    volume: string
    median_price: string


proc getMinItem(appid: int, vallet: int, market_hash_name: string): MinItem =
  let url = "https://steamcommunity.com/market/priceoverview/?appid="&intToStr(
      appid)&"&currency="&intToStr(vallet)&"&market_hash_name="&escapeLink(market_hash_name)
  let jsonObject = parseJson(client.getContent(url))
  return to(jsonObject, MinItem)



echo getMinItem(730, 1, "★ Karambit | Doppler (Factory New)")



######################################
# Trade Market Service (IEconService)
# https://partner.steamgames.com/doc/webapi/IEconService
######################################


type
  TradeAsset = object
    appid: int
    contextid: string
    assetid: string
    amount: string
    classid: string
    instanceid: string
    new_assetid: string
    new_contextid: string

  Trade = object
    tradeid: string
    steamid_other: string
    time_init: int
    status: int
    assets_received*: seq[TradeAsset]
    assets_given*: seq[TradeAsset]



proc tradeHistory(max_trades: int): seq[Trade] =
  let url = "https://api.steampowered.com/IEconService/GetTradeHistory/v1/?key="&steamWebAPIKey&"&max_trades="&intToStr(max_trades)
  let jsonObject = parseJson(client.getContent(url))
  let jsonResponse = jsonObject["response"]
  let jsonTrades = jsonResponse["trades"]
  doAssert jsonTrades.kind == JArray
  for jsonTrade in jsonTrades:
    if not jsonTrade.hasKey("assets_received"):
      jsonTrade.add("assets_received", parseJson("[]"))
    if not jsonTrade.hasKey("assets_given"):
      jsonTrade.add("assets_given", parseJson("[]"))
    result.add(to(jsonTrade, Trade))
  return result


echo tradeHistory(1)

