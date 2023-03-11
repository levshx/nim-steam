## 
## :Author: levshx
## :Version: 0.0.2
## This library allows you to use the open Web API Steam.
## 
##
## Overview
## ========
##
## Create WebAPI client
## --------------------
##
## Use only `var`
##
## .. code-block:: Nim
##   import steam/webapi
##
##
##   # Create Steam session
##   var webAPI = newSteamWebAPI(keySteam) 
##
##

import json, httpclient, uri, strutils, options

type
  SteamWebAPI = object  ## Client Steam class
    steamWebAPIKey: string
    apilist: JsonNode

proc newSteamWebAPI*(steamWebAPIKey: string): SteamWebAPI =
  ## Create Steam client
  result.steamWebAPIKey = steamWebAPIKey
  result.apilist = parseJson(newHttpClient().getContent("https://api.steampowered.com/ISteamWebAPIUtil/GetSupportedAPIList/v1/?key="&steamWebAPIKey))

proc newSteamWebAPI*(): SteamWebAPI =
  ## Create Steam client without key
  result.steamWebAPIKey = ""
  result.apilist = parseJson(newHttpClient().getContent("https://api.steampowered.com/ISteamWebAPIUtil/GetSupportedAPIList/v1/"))

proc getSupportedAPIList*(client: SteamWebAPI): JsonNode =
  return client.apilist

proc getServerInfo*(client: SteamWebAPI): JsonNode =
  return parseJson(newHttpClient().getContent("https://api.steampowered.com/ISteamWebAPIUtil/GetServerInfo/v1/"))


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
    url = url & "?" & encodeUrl(params[0].name) & "=" & encodeUrl(params[0].value)
    params.del(0)
  for param in params:
    url = url & "&" & encodeUrl(param.name) & "=" & encodeUrl(param.value)
  return parseJson(newHttpClient().getContent(url))


#
# Call without params
#
proc call*(client: SteamWebAPI, interfaceName: string, methodName: string, version:int): JsonNode =
  var url = "https://api.steampowered.com/" & interfaceName & "/" & methodName & "/v" & $version & "/"
  if (client.steamWebAPIKey!=""):   
    url = url & "?key=" & client.steamWebAPIKey
  return parseJson(newHttpClient().getContent(url))