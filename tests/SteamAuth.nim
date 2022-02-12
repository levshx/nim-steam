import ../src/steam

var steamClient = newSteamClient()

var auth_result = steamClient.auth("login", "pass", "secret")
