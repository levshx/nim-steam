import json, httpclient, strutils

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
    SteamClient = object  
        steamWebAPIKey: string
        steam_login: string
        steam_password: string



proc newSteamClient*(keyWebAPI:string): SteamClient =
    result.steamWebAPIKey = keyWebAPI

proc `keyAPI=`*(s: var SteamClient, value: string) {.inline.} =
  s.steamWebAPIKey = value

proc keyAPI*(s: SteamClient): string {.inline.} =
  s.steamWebAPIKey


######################################
# SteamwebAPI Service (ISteamwebAPIUtil)
# Method (GetServerInfo) v1
# https://api.steampowered.com/IEconService/GetTradeHistory/v1/
######################################
type
  ServerInfo = object
    servertime: int
    servertimestring: string
    
proc getServerInfo*(client: SteamClient): ServerInfo =
  let url = "https://api.steampowered.com/ISteamwebAPIUtil/GetServerInfo/v1/"
  let jsonObject = parseJson(newHttpClient().getContent(url))
  return to(jsonObject, ServerInfo)


######################################
# Price Over View (NO API)
# market/priceoverview/
# https://steamcommunity.com/market/priceoverview/
######################################
type
  MinItem = object
    success: bool
    lowest_price: string
    volume: string
    median_price: string


proc getMinItem*(client: SteamClient, appid: int, vallet: int, market_hash_name: string): MinItem =
  let url = "https://steamcommunity.com/market/priceoverview/?appid="&intToStr(
      appid)&"&currency="&intToStr(vallet)&"&market_hash_name="&escapeLink(market_hash_name)
  let jsonObject = parseJson(newHttpClient().getContent(url))
  return to(jsonObject, MinItem)


######################################
# Trade Market Service (IEconService)
# Method (GetTradeHistory) v1
# https://api.steampowered.com/IEconService/GetTradeHistory/v1/
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



proc tradeHistory*(client: SteamClient,max_trades: int): seq[Trade] =
  let url = "https://api.steampowered.com/IEconService/GetTradeHistory/v1/?key="&client.steamWebAPIKey&"&max_trades="&intToStr(max_trades)
  let jsonObject = parseJson(newHttpClient().getContent(url))
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
