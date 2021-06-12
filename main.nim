import json, httpclient, strutils
# for compile use -d:ssl

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
    let url = "https://steamcommunity.com/market/priceoverview/?appid="&intToStr(appid)&"&currency="&intToStr(vallet)&"&market_hash_name="&escapeLink(market_hash_name)
    let jsonObject = parseJson(client.getContent(url))
    return to(jsonObject, MinItem)


let test = getMinItem(730,1,"StatTrak™ M4A1-S | Hyper Beast (Minimal Wear)")  

echo test