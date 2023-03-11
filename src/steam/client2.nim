## 
## :Author: levshx
## :Version: 0.0.2
## 


import httpclient, tables,  strutils, json, options, times, uri, protobuf

include client/rsaPassword

type
  SteamClient* = object 
    httpclient: HttpClient
    session: SessionData
    captcha_gid: string

  SessionData = object
    ga: string
    gid: string
    sessionid: string
    browserid: string
    steamid: string
    steamCountry: string
    steamLoginSecure: string # token_secure
    steamMachineAuth: string # webcookie
    steamRememberLogin: string
    timezoneOffset: string


proc newSteamClient*(): SteamClient =
  ## Create Steam client
  result.httpclient = newHttpClient()


type
  RSAKey = object
    success: bool
    publickey_mod: string
    publickey_exp: string
    timestamp: string
    token_gid: string

proc parseSetCookies(client: var SteamClient, headers: HttpHeaders) = 
  if headers.hasKey("Set-Cookie"):
    for cookie in headers.table["set-cookie"]:
      if cookie.split(";")[0].find("sessionid=") != -1:
        client.session.sessionid = cookie.split(";")[0].split("=")[1]
      if cookie.split(";")[0].find("browserid=") != -1:
        client.session.browserid = cookie.split(";")[0].split("=")[1]     
      if cookie.split(";")[0].find("ga=") != -1:
        client.session.ga = cookie.split(";")[0].split("=")[1]
      if cookie.split(";")[0].find("gid=") != -1:
        client.session.gid = cookie.split(";")[0].split("=")[1]
      if cookie.split(";")[0].find("steamCountry=") != -1:
        client.session.steamCountry = cookie.split(";")[0].split("=")[1] 
      if cookie.split(";")[0].find("steamLoginSecure=") != -1:
        client.session.steamLoginSecure = cookie.split(";")[0].split("=")[1]
        client.session.steamid = client.session.steamLoginSecure.split("%")[0]
      if cookie.split(";")[0].find("steamMachineAuth") != -1:
        client.session.steamMachineAuth = cookie.split(";")[0].split("=")[1]
      if cookie.split(";")[0].find("steamRememberLogin=") != -1:
        client.session.steamRememberLogin = cookie.split(";")[0].split("=")[1]
      if cookie.split(";")[0].find("timezoneOffset=") != -1:
        client.session.steamRememberLogin = cookie.split(";")[0].split("=")[1]
  


proc saveSession*(client: SteamClient, path: string): bool =
  ## Performs serialization of the user's session into a json file.
  var json = %* { 
    "ga": client.session.ga,
    "gid": client.session.gid,
    "sessionid": client.session.sessionid,
    "steamid": client.session.steamid,
    "steamCountry": client.session.steamCountry,
    "steamLoginSecure": client.session.steamLoginSecure,
    "steamMachineAuth": client.session.steamMachineAuth,
    "steamRememberLogin": client.session.steamRememberLogin,
    "timezoneOffset": client.session.timezoneOffset,
    "browserid": client.session.browserid
  }
  try:
    writeFile(path, $json)
  except: return false
  return true

proc loadSession*(client: var SteamClient, path: string): bool =
  ## Performs the serialization of a json file into a Steam user session.
  try:
    client.session = to(parseJson(readFile(path)), SessionData)
  except: return false
  return true

proc cookies(client: SteamClient): string = 
  result = ""
  if client.session.browserid.len>0:
    result.add("browserid="&client.session.browserid&";")
  if client.session.sessionid.len>0:
    result.add("sessionid="&client.session.sessionid&";")
  if client.session.steamCountry.len>0:
    result.add("steamCountry="&client.session.steamCountry&";")
  if client.session.steamLoginSecure.len>0:
    result.add("steamLoginSecure="&client.session.steamLoginSecure&";")
  if client.session.steamMachineAuth.len>0:
    result.add("steamMachineAuth"&client.session.steamid&"="&client.session.steamMachineAuth&";")
  if client.session.steamRememberLogin.len>0:
    result.add("steamRememberLogin="&client.session.steamRememberLogin&";")
  

proc createSession(client: var SteamClient) =
  let url = "https://store.steampowered.com/"
  let response = client.httpclient.request(url, HttpGET)
  client.parseSetCookies(response.headers)

proc clearSession(client: var SteamClient) =
  client.session.ga = ""
  client.session.gid = ""
  client.session.sessionid = ""
  client.session.browserid = ""
  client.session.steamid = ""
  client.session.steamCountry = ""
  client.session.steamLoginSecure = ""
  client.session.steamMachineAuth = ""
  client.session.steamRememberLogin = ""
  client.session.timezoneOffset = ""

proc getRSAKey(client: var SteamClient,  username: string): RSAKey =
  let url = "https://store.steampowered.com/login/getrsakey/?username=" & $username
  var mainHeaders = newHttpHeaders()
  mainHeaders.add("Content-Type", "application/x-www-form-urlencoded")
  mainHeaders.add("Cookie", client.cookies)
  let response = client.httpclient.request(url, HttpGet, headers = mainHeaders)
  client.parseSetCookies(response.headers)
  echo response.body
  let jsonObject = parseJson(response.body)
  result = to(jsonObject, RSAKey)
  return result

type
  DoLoginResponse = object
    success: bool
    requires_twofactor: Option[bool]
    login_complete: Option[bool]
    transfer_urls: Option[seq[string]]
    transfer_parameters: Option[TransferParams]
    captcha_needed: Option[bool]
    captcha_gid: Option[int]
  TransferParams = object 
    steamid: Option[string]
    token_secure: Option[string]
    auth: Option[string]
    remember_login: Option[bool]
    webcookie: Option[string]

proc doLogin(client: var SteamClient, username, password, rsatimestamp, secret, captcha_text: string): DoLoginResponse =
  let url = "https://steamcommunity.com/login/dologin/"
  let body = "donotcache=" & $(toUnix(toTime(now()))+150) & "000" & "&password=" & encodeUrl(password) & "&username=" & encodeUrl(username) & "&twofactorcode=" & secret & "&emailauth=&loginfriendlyname=&captchagid=-1&captcha_text=" & encodeUrl(captcha_text) & "&emailsteamid=&rsatimestamp=" & rsatimestamp & "&remember_login=true"
  var mainHeaders = newHttpHeaders()
  mainHeaders.add("Content-Type", "application/x-www-form-urlencoded")
  mainHeaders.add("Cookie", client.cookies)
  let response = client.httpclient.request(url, HttpPOST, body = body, mainHeaders)
  client.parseSetCookies(response.headers)
  let jsonObject = parseJson(response.body)
  result = to(jsonObject, DoLoginResponse)
  echo result
  return result

proc auth*(client: var SteamClient,  username: string, password: string, secret = "", captcha_text = ""): bool =
  ## Performs Steam user authorization and saves the session in the SteamClient object.
  var loginResponse: DoLoginResponse
  try:
    client.clearSession()
    client.createSession()
    echo "step1"    
    var data_RSA = client.getRSAKey(username) 
    echo "step2" 
    var encrypted_password = encryptPassword(data_RSA.publickey_mod, data_RSA.publickey_exp, password)
    echo "step3"
    loginResponse = client.doLogin(username, encrypted_password, data_RSA.timestamp, secret, captcha_text)
    echo "step4" 
  except: 
    echo "ERROR steamClient.auth"
    return false
  finally: 
    echo client.cookies()
    return loginResponse.success

proc commentProfile*(client: var SteamClient, message: string, user_id: int64): bool =
  ## Write a comment on the Steam user profile.
  try:
    let url = "https://steamcommunity.com/comment/Profile/post/" & $user_id & "/-1/"
    let body = "comment=" & encodeUrl(message) & "&count=6&sessionid=" & client.session.sessionid & "&feature2=-1"
    var mainHeaders = newHttpHeaders()
    mainHeaders.add("Content-Type", "application/x-www-form-urlencoded")
    mainHeaders.add("Cookie", client.cookies)
    let response = client.httpclient.request(url, HttpPOST, body = body, mainHeaders)
    echo response.body
    echo "responce status ", response.status
    let jsonObject = parseJson(response.body)
    result = jsonObject["success"].getBool()
  except: 
    return false
  finally: 
    result = result


type
  Notifications* = object
    trades*: int #1
    unknown2*: int #2
    community*: int #3
    comments*: int #4
    unknown5*: int #5
    friends*: int #6
    unknown8*: int #8
    messages*: int #9
    unknown10*: int #10
    unknown11*: int #11

proc getNotifications*(client: var SteamClient): Notifications =
  ## Get the number of Steam notifications (not a callback).
  try:
    let url = "https://steamcommunity.com/actions/GetNotificationCounts"
    var mainHeaders = newHttpHeaders()
    mainHeaders.add("Content-Type", "application/x-www-form-urlencoded")
    mainHeaders.add("Cookie", client.cookies)
    let response = client.httpclient.request(url, HttpGET, headers = mainHeaders)
    let jsonObject = parseJson(response.body)
    result.trades = jsonObject["notifications"]["1"].getInt()
    result.messages = jsonObject["notifications"]["9"].getInt()
    result.unknown2 = jsonObject["notifications"]["2"].getInt()
    result.community = jsonObject["notifications"]["3"].getInt()
    result.comments = jsonObject["notifications"]["4"].getInt()
    result.unknown5 = jsonObject["notifications"]["5"].getInt()
    result.friends = jsonObject["notifications"]["6"].getInt()
    result.unknown8 = jsonObject["notifications"]["8"].getInt()
    result.unknown10 = jsonObject["notifications"]["10"].getInt()
    result.unknown11 = jsonObject["notifications"]["11"].getInt()
  except: 
    return result
  finally: 
    result = result