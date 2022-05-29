import os, httpclient, asyncdispatch, builded_webapi, options

converter toOption*[T](x:T):Option[T] = some(x)

var asyncClient = newAsyncSteamWebAPI()

echo waitfor asyncClient.IGCVersion_1046930.GetServerVersionV1() 