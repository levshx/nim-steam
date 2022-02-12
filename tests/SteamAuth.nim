import ../src/steam, strutils, json, bigints, std/math, std/algorithm

var steamClient = newSteamClient()

var auth_result = steamClient.auth("username", "password", "secret")

