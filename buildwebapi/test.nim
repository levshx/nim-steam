import os, asyncdispatch, builded_webapi

var asyncClient = newAsyncSteamWebAPI()
var a = asyncClient.ISteamWebAPIUtil.GetServerInfoV1()

a.addCallback(
  proc () =
    echo("a callback")
)


os.sleep(5000)

var client = newSteamWebAPI()
var s = client.ISteamWebAPIUtil.GetServerInfoV1()

echo waitfor a 
echo s 