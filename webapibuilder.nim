import os, httpclient, strutils, json, std/options, times, uri

var APILIST: JsonNode
const url = "https://api.steampowered.com/ISteamWebAPIUtil/GetSupportedAPIList/v1/"

if paramCount() == 0:
  quit("NO PARAM (use -keyless or steam web api key)", QuitFailure)
elif paramStr(1) == "-keyless":
  APILIST = parseJson(newHttpClient().getContent(url))
else:
  APILIST = parseJson(newHttpClient().getContent(url&"?key="&paramStr(1)))


var imports = "import asyncdispatch, httpclient, uri, strutils, options\n"
imports.add("## :Author: levshx\n## :Generator: https://github.com/levshx/nim-steam/\n## :Date: " & $getTime().utc())
var consts = "\nconst\n  WEBAPI_BASE_URL* =\n    when defined(ssl): \"https://api.steampowered.com/\" ## Steam API URL (SSL).\n    else:              \"http://api.steampowered.com/\"  ## Steam API URL (No SSL).\n"
consts.add("converter toOption*[T](x:T):Option[T] = some(x)")
var types = "\ntype\n  Rawbinary* = string\n  Message* = string\n  Param = object\n    name: string\n    value: string"
var addSyncType = "\n  SteamWebAPI* = object\n    ## Sync steam WebAPI client"
var addAsyncType = "\n  AsyncSteamWebAPI* = object\n    ## Async steam WebAPI client"
var interTypes = ""
var syncConstruct = "\n\nproc newSteamWebAPI*():SteamWebAPI="
var asyncConstruct = "\n\nproc newAsyncSteamWebAPI*():AsyncSteamWebAPI="
var syncMethods = "\n\nproc newParam(name:string, value:string):Param=\n"
syncMethods.add("  result.name=name\n  result.value=value\n\n")
syncMethods.add("proc prm2get(s:seq[Param]):string =\n  if s.len>0:\n    for i in countup(0,s.len-1):\n      result.add((if i==0:\"?\"else:\"&\")&s[i].name&\"=\"&encodeUrl(s[i].value))\n\n")
syncMethods.add("proc prm2post(s:seq[Param]):string=\n  if s.len>0:\n    for i in countup(0,s.len-1):\n      result.add((if i==0:\"\"else:\"&\")&s[i].name&\"=\"&encodeUrl(s[i].value)) ")
var asyncMethods = ""

for steamInterface in APILIST["apilist"]["interfaces"]:
  let intName = multiReplace($steamInterface["name"], ("\"",""))
  addSyncType.add( "\n    " & intName & "*:" & intName)
  addAsyncType.add( "\n    " & intName & "*: Async" & intName)
  # Sync
  interTypes.add( "\n  " & intName & " = object " & "\n    name*:string\n    methods*: seq[string]")
  # Async
  interTypes.add( "\n  Async" & intName & " =  object " & "\n    name*:string\n    methods*: seq[string]")
  syncConstruct.add("\n  result."&intName&".name = \"" & intName & "\"" )
  asyncConstruct.add("\n  result."&intName&".name = \"" & intName & "\"" )
  for interfaceMethod in steamInterface["methods"]:    
    var methodParamsDesc = ""
    var paramsPrepose = "\n  var params: seq[Param]"
    let methodName = multiReplace($interfaceMethod["name"], ("\"",""))
    let methodVer = multiReplace($interfaceMethod["version"], ("\"",""))
    let methodHTTP = multiReplace($interfaceMethod["httpmethod"], ("\"",""))
    var urlCode = "\n  let url = WEBAPI_BASE_URL & interfacename.name & \"/"&methodName&"/v"&methodVer&"/\"" & (if interfaceMethod["parameters"].len > 0 and methodHTTP=="GET":"&prm2get(params)"else:"")
    syncConstruct.add( "\n  result." & intName & ".methods.add(\"" & methodName & ":V" & methodVer & "\")")
    asyncConstruct.add( "\n  result." & intName & ".methods.add(\"" & methodName & ":V" & methodVer & "\")")
    syncMethods.add("\n\nproc `" & methodName & "V" & methodVer & "`*(interfacename: " & intName )
    asyncMethods.add("\n\nproc `" & methodName & "V" & methodVer & "`*(interfacename: Async" & intName )    
    if interfaceMethod["parameters"].len > 0:
      for methodParametr in interfaceMethod["parameters"]:        
        let paramName = multiReplace($methodParametr["name"], ("\"","")) 
        let paramOpt = if(methodParametr["optional"].getBool()):true else: false
        let paramType = multiReplace(multiReplace(multiReplace(multiReplace($methodParametr["type"], ("\"","")), ("{message}","Message")), ("rawbinary","Rawbinary")), ("{enum}","int"))       
        if paramName.contains("[0]"):
          var paramSeqName = paramName
          paramSeqName.delete(paramName.len-3..paramName.len-1)   
          syncMethods.add(", `" & paramSeqName & "`=none(seq[" & paramType & "])")
          asyncMethods.add(", `" & paramSeqName & "`=none(seq[" & paramType & "])")
          paramsPrepose.add("\n  if `"&paramSeqName&"`.isSome() and `"&paramSeqName&"`.get().len>0: \n    for key, value in `"&paramSeqName&"`.get():\n      params.add(newParam(\""&paramSeqName&"[\" & $key & \"]\",$(`"&paramSeqName&"`.get()[key])))")
          methodParamsDesc.add("\n  ## `"&paramSeqName&"` : "&"seq["&paramType&"] — "&(if paramOpt:"(Optional)" else: "(Required)")&" " & methodParametr{"description"}.getStr())
        else:  
          syncMethods.add(", `" & paramName & "`=none(" & paramType&")")
          asyncMethods.add(", `" & paramName & "`=none(" & paramType&")")
          paramsPrepose.add("\n  if `" & paramName&"`.isSome(): \n    params.add(newParam(\""&paramName&"\", $"&paramName&"))")
          methodParamsDesc.add("\n  ## `"&paramName&"` : " & paramType & " — "&(if paramOpt:"(Optional)" else: "(Required)")&" " & methodParametr{"description"}.getStr())
    syncMethods.add("): string = ")
    asyncMethods.add("): Future[string] {.async.} = ")
    if interfaceMethod{"description"}.getStr() != "":
      syncMethods.add("\n  ## " & interfaceMethod["description"].getStr())
      asyncMethods.add("\n  ## " & interfaceMethod["description"].getStr())
    syncMethods.add(methodParamsDesc)
    asyncMethods.add(methodParamsDesc)
    if interfaceMethod["parameters"].len > 0:
      syncMethods.add(paramsPrepose)
      asyncMethods.add(paramsPrepose)
      if methodHTTP=="POST":
        syncMethods.add("\n  let body = prm2post(params)")
        asyncMethods.add("\n  let body = prm2post(params)")
    syncMethods.add("\n  # HTTP METHOD "&methodHTTP)
    asyncMethods.add("\n  # HTTP METHOD "&methodHTTP)
    syncMethods.add(urlCode)
    asyncMethods.add(urlCode)
    if methodHTTP == "GET":
      syncMethods.add("\n  var client = newHttpClient()\n  return client.getContent(url) ")
      asyncMethods.add("\n  var client = newAsyncHttpClient()\n  return await client.getContent(url) ")
    else:
      syncMethods.add("\n  var client = newHttpClient()\n  client.headers = newHttpHeaders({ \"Content-Type\": \"application/x-www-form-urlencoded\" }) \n  return client.postContent(url"&(if interfaceMethod["parameters"].len > 0:", body = body" else: "" )&") ")
      asyncMethods.add("\n  var client = newAsyncHttpClient()\n  client.headers = newHttpHeaders({ \"Content-Type\": \"application/x-www-form-urlencoded\" }) \n  return await client.postContent(url"&(if interfaceMethod["parameters"].len > 0:", body = body" else: "" )&") ")

syncConstruct.add("\n  return result\n")
asyncConstruct.add("\n  return result\n")

var compose = imports & consts & types & addSyncType & addAsyncType & interTypes & syncConstruct & asyncConstruct & syncMethods & asyncMethods

if  dirExists("buildwebapi"):
  writeFile("buildwebapi/builded_webapi.nim", compose)
else:
  createDir("buildwebapi")
  writeFile("buildwebapi/builded_webapi.nim", compose)