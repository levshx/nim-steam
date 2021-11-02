import json, httpclient, strutils, options

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
  SteamWebAPI = object  ## Client Steam class
    steamWebAPIKey: string
    apilist: JsonNode

proc newSteamWebAPI*(steamWebAPIKey: string): SteamWebAPI =
  ## Create Steam client
  result.steamWebAPIKey = steamWebAPIKey
  result.apilist = parseJson(newHttpClient().getContent("https://api.steampowered.com/ISteamWebAPIUtil/GetSupportedAPIList/v1/?key="&steamWebAPIKey))

proc newSteamWebAPI*(): SteamWebAPI =
  ## Create Steam client
  result.steamWebAPIKey = ""
  result.apilist = parseJson(newHttpClient().getContent("https://api.steampowered.com/ISteamWebAPIUtil/GetSupportedAPIList/v1/"))

proc getSupportedAPIList*(client: SteamWebAPI): JsonNode =
  return client.apilist

proc getServerInfo*(client: SteamWebAPI): JsonNode =
  return parseJson(newHttpClient().getContent("https://api.steampowered.com/ISteamWebAPIUtil/GetSupportedAPIList/v1/?key="&client.steamWebAPIKey))


#
# Web API Call
#

type 
  Param = object
    name: string
    value: string

proc newParam*(name: string, value: string): Param =
  result.name = name
  result.value = value

#
# Call with params
#
proc call*(client: SteamWebAPI, interfaceName: string, methodName: string, version:int, params: seq[Param]): JsonNode =
  var params = params
  var url = "https://api.steampowered.com/" & interfaceName & "/" & methodName & "/v" & $version & "/"
  if (client.steamWebAPIKey!=""):
    params.add(newParam("key",client.steamWebAPIKey))
  if params.len>0:
    url = url & "?" & escapeLink(params[0].name) & "=" & escapeLink(params[0].value)
    params.del(0)
  for param in params:
    url = url & "&" & escapeLink(param.name) & "=" & escapeLink(param.value)
  return parseJson(newHttpClient().getContent(url))


#
# Call without params
#
proc call*(client: SteamWebAPI, interfaceName: string, methodName: string, version:int): JsonNode =
  var url = "https://api.steampowered.com/" & interfaceName & "/" & methodName & "/v" & $version & "/"
  if (client.steamWebAPIKey!=""):   
    url = url & "?key=" & client.steamWebAPIKey
  return parseJson(newHttpClient().getContent(url))