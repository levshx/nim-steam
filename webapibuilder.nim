import os, httpclient, strutils, json, std/options, times, uri

var APILIST: JsonNode
const url = "https://api.steampowered.com/ISteamWebAPIUtil/GetSupportedAPIList/v1/"

if paramCount() == 0:
  quit("NO PARAM (use -keyless or steam web api key)", QuitFailure)
elif paramStr(1) == "-keyless":
  APILIST = parseJson(newHttpClient().getContent(url))
else:
  APILIST = parseJson(newHttpClient().getContent(url&"?key="&paramStr(1)))


var imports = "import json, httpclient, uri, strutils, options\n\ntype\n  SteamWebAPI = object  ## Client Steam class"
var attachToSteamWebAPI = ""
var interfacesTypesCode = ""
var construct = "\n\nproc newSteamWebAPI*(): SteamWebAPI ="
var methods = ""

for steamInterface in APILIST["apilist"]["interfaces"]:
  attachToSteamWebAPI.add( "\n    " & multiReplace($steamInterface["name"], ("\"","")) & "*:" & multiReplace($steamInterface["name"], ("\"","")))
  interfacesTypesCode.add( "\n  " & multiReplace($steamInterface["name"], ("\"","")) & " = object " & "\n    name:string\n    methods: seq[string]")
  construct.add("\n  result."& multiReplace($steamInterface["name"], ("\"","")) & ".name = " & $steamInterface["name"] )
  for interfaceMethod in steamInterface["methods"]:
    construct.add( "\n  result."& multiReplace($steamInterface["name"], ("\"","")) & ".methods.add(" & $interfaceMethod["name"] & ")")
    methods.add("\n\nproc `" & multiReplace($interfaceMethod["name"], ("\"",""))& "V" & multiReplace($interfaceMethod["version"], ("\"","")) & "`*(interfacename: "& multiReplace($steamInterface["name"], ("\"","")) )
    if interfaceMethod["parameters"].len > 0:
      for methodParametr in interfaceMethod["parameters"]:
        methods.add(", `"&multiReplace($methodParametr["name"], ("\"",""))& "`:" & multiReplace(multiReplace(multiReplace($methodParametr["type"], ("\"","")), ("{message}","string")), ("rawbinary","string")))
    methods.add("): JsonNode = return parseJson(\"\")")

construct.add("\n  return result\n")

var compose = imports & attachToSteamWebAPI & interfacesTypesCode & construct & methods

writeFile("buildwebapi/builded_webapi.nim", compose)