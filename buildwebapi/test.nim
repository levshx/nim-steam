import asyncdispatch, builded_webapi, options

var asyncClient = newAsyncSteamWebAPI()

echo waitfor asyncClient.IPortal2Leaderboards_620.GetBucketizedDataV1() 