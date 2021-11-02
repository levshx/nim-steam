import ../src/steam/webapi, strutils, json

var steamWebAPI = newSteamWebAPI()

let output = steamWebAPI.call("ISteamWebAPIUtil","GetServerInfo", 1)
echo output