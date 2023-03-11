## 
## :Author: levshx
## :Version: 0.0.2
## 

import json, httpclient, strutils, uri

type
  MinItem* = object ## Это класс минимальной информации стоимости предмета на торговой площадке Steam
    success*: bool
    lowest_price*: string
    volume*: string
    median_price*: string

proc getAssetMarketPriceOverview*(appid: int, vallet: int,
    market_hash_name: string): MinItem =
  ## Процедура получения минимальной информации стоимости предмета
  ## на торговой площадке Steam
  let url = "https://steamcommunity.com/market/priceoverview/?appid="&intToStr(
      appid)&"&currency="&intToStr(vallet)&"&market_hash_name="&encodeUrl(market_hash_name)
  let jsonObject = parseJson(newHttpClient().getContent(url))
  return to(jsonObject, MinItem)


# http://steamcommunity.com/market/listings/730/AK-47%20%7C%20Redline%20%28Field-Tested%29/render?start=0&count=1&currency=1&format=json


proc getAssetMarketIconURL*(icon_code: string): string =
  let url = "http://cdn.steamcommunity.com/economy/image/"&icon_code
  return url


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

# Parse profile XML
# https://steamcommunity.com/profiles/76561198859045421/?xml=1
