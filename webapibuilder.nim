import os, httpclient, strutils, json, std/options, times, uri, options

var APILIST: JsonNode
const url = "https://api.steampowered.com/ISteamWebAPIUtil/GetSupportedAPIList/v1/"

if paramCount() == 0:
  quit("NO PARAM (use -keyless or steam web api key)", QuitFailure)
elif paramStr(1) == "-keyless":
  APILIST = parseJson(newHttpClient().getContent(url))
else:
  APILIST = parseJson(newHttpClient().getContent(url&"?key="&paramStr(1)))


var imports = "import asyncdispatch, httpclient, uri, strutils, options\n"
imports.add("## :Author: levshx\n## :Generated: " & $getTime().utc() & "\n")
var consts = "const\n  WEBAPI_BASE_URL* =\n    when defined(ssl): \"https://api.steampowered.com/\" ## Steam API URL (SSL).\n    else:              \"http://api.steampowered.com/\"  ## Steam API URL (No SSL)."
var types = "\ntype\n  Rawbinary* = string\n  Message* = string"
var addSyncType = "\n  SteamWebAPI* = object\n    ## Sync steam WebAPI client"
var addAsyncType = "\n  AsyncSteamWebAPI* = object\n    ## Async steam WebAPI client"
var interTypes = ""
var syncConstruct = "\n\nproc newSteamWebAPI*(): SteamWebAPI ="
var asyncConstruct = "\n\nproc newAsyncSteamWebAPI*(): AsyncSteamWebAPI ="
var syncMethods = ""
var asyncMethods = ""

for steamInterface in APILIST["apilist"]["interfaces"]:
  let intName = multiReplace($steamInterface["name"], ("\"",""))
  addSyncType.add( "\n    " & intName & "*:" & intName)
  addAsyncType.add( "\n    " & intName & "*: Async" & intName)
  # Sync
  interTypes.add( "\n  " & intName & " = object " & "\n    name*:string\n    methods*: seq[string]")
  # Async
  interTypes.add( "\n  Async" & intName & " =  object " & "\n    name*:string\n    methods*: seq[string]")
  syncConstruct.add("\n  result."& intName & ".name = \"" & intName & "\"" )
  asyncConstruct.add("\n  result."& intName & ".name = \"" & intName & "\"" )
  for interfaceMethod in steamInterface["methods"]:    
    var methodParamsDesc = ""
    var methodParamList: seq[string]
    let methodName = multiReplace($interfaceMethod["name"], ("\"",""))
    let methodVer = multiReplace($interfaceMethod["version"], ("\"",""))
    let methodHTTP = multiReplace($interfaceMethod["httpmethod"], ("\"",""))
    var urlCode = "\n  let url = WEBAPI_BASE_URL & interfacename.name & \"/"&methodName&"/v"&methodVer&"/\""
    syncConstruct.add( "\n  result."& intName & ".methods.add(\"" & methodName & ":V"& methodVer & "\")")
    asyncConstruct.add( "\n  result."& intName & ".methods.add(\"" & methodName & ":V"& methodVer & "\")")
    syncMethods.add("\n\nproc `" & methodName & "V" & methodVer & "`*(interfacename: "& intName )
    asyncMethods.add("\n\nproc `" & methodName & "V" & methodVer & "`*(interfacename: Async"& intName )    
    if interfaceMethod["parameters"].len > 0:
      for methodParametr in interfaceMethod["parameters"]:        
        let paramName = multiReplace($methodParametr["name"], ("\"",""))              
        let paramType = multiReplace(multiReplace(multiReplace(multiReplace($methodParametr["type"], ("\"","")), ("{message}","Message")), ("rawbinary","Rawbinary")), ("{enum}","int"))
        #param description
        if methodParametr{"description"}.getStr() != "":
          methodParamsDesc.add("\n  ## `"&paramName&"` : "& paramType & " — " & methodParametr{"description"}.getStr())
        if paramName.contains("[0]"):
          var paramSeqName = paramName
          paramSeqName.delete(paramName.len-3,paramName.len-1)   
          syncMethods.add(", `" & paramSeqName & "`: seq[" & paramType & "]")
          asyncMethods.add(", `" & paramSeqName & "`: seq[" & paramType & "]")
        else:  
          syncMethods.add(", `" & paramName & "`: " & paramType)
          asyncMethods.add(", `" & paramName & "`: " & paramType)
    syncMethods.add("): string = ")
    asyncMethods.add("): Future[string] {.async.} = ")
    if interfaceMethod{"description"}.getStr() != "":
      syncMethods.add("\n  ## " & interfaceMethod["description"].getStr())
      asyncMethods.add("\n  ## " & interfaceMethod["description"].getStr())
    syncMethods.add(methodParamsDesc)
    asyncMethods.add(methodParamsDesc)
    syncMethods.add("\n  ## HTTP METHOD "&methodHTTP)
    asyncMethods.add("\n  ## HTTP METHOD "&methodHTTP)
    syncMethods.add(urlCode)
    asyncMethods.add(urlCode)
    if methodHTTP == "GET":
      syncMethods.add("\n  var client = newHttpClient()\n  return client.getContent(url) ")
      asyncMethods.add("\n  var client = newAsyncHttpClient()\n  return await client.getContent(url) ")
    else:
      syncMethods.add("\n  var client = newHttpClient()\n  return client.postContent(url, multipart=nil) ")
      asyncMethods.add("\n  var client = newAsyncHttpClient()\n  return await client.postContent(url, multipart=nil) ")

syncConstruct.add("\n  return result\n")
asyncConstruct.add("\n  return result\n")

var compose = imports & consts & types & addSyncType & addAsyncType & interTypes & syncConstruct & asyncConstruct & syncMethods & asyncMethods

writeFile("buildwebapi/builded_webapi.nim", compose)