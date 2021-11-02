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
  MinItem* = object ## Это класс минимальной информации стоимости предмета на торговой площадке Steam
    success*: bool
    lowest_price*: string
    volume*: string
    median_price*: string


proc getMinItem*(appid: int, vallet: int,
    market_hash_name: string): MinItem =
  ## Процедура получения минимальной информации стоимости предмета
  ## на торговой площадке Steam
  let url = "https://steamcommunity.com/market/priceoverview/?appid="&intToStr(
      appid)&"&currency="&intToStr(vallet)&"&market_hash_name="&escapeLink(market_hash_name)
  let jsonObject = parseJson(newHttpClient().getContent(url))
  return to(jsonObject, MinItem)


#
# Get Icon URL
# http://cdn.steamcommunity.com/economy/image/ +IMAGE CODE
#

proc getAssetMarketIconURL*(icon_code: string): string =
  let url = "http://cdn.steamcommunity.com/economy/image/"&icon_code
  return url


#
# Inventory (NO API)
# CARD
# https://steamcommunity.com/inventory/76561198082780051/730/2
#
type
  InventoryAsset* = object
    appid*: int
    classid*: string
    instanceid*: string
    currency*: int
    icon_url*: string
    tradable*: int
    name*: string
    name_color*: string
    market_name*: string
    market_hash_name*: string
    commodity*: int
    market_tradable_restriction*: int
    marketable*: int

proc getProfileInventory*(steamID64: int64, gameID: int,
    valueWTF: int): seq[InventoryAsset] =
  let url = "https://steamcommunity.com/inventory/"&($steamID64)&"/"&(
      $gameID)&"/"&($valueWTF)
  let jsonObject = parseJson(newHttpClient().getContent(url))
  let jsonDescriptions = jsonObject["descriptions"] # More Information
  doAssert jsonDescriptions.kind == JArray
  for jsonAsset in jsonDescriptions:
    result.add(to(jsonAsset, InventoryAsset))
  return result
