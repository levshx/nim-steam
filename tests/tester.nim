import steam/webapi, strutils, json

var steamWebAPI = newSteamWebAPI()

let output = steamWebAPI.call("ISteamWebAPIUtil","GetServerInfo", 1)
echo output

var steamClient = newSteamClient()

var auth_result = steamClient.auth("levshx", "passwort", "G868X")

echo auth_result