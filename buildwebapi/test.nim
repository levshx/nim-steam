import os, httpclient, asyncdispatch, builded_webapi, options

converter toOption*[T](x:T):Option[T] = some(x)

var asyncClient = newAsyncSteamWebAPI()

var steamid: uint64 
steamid = 730

# TODO

var asyncResult = asyncClient.IGCVersion_1046930.GetServerVersionV1()


echo waitfor asyncResult 