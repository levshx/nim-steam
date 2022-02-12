import std/[httpclient, json], strutils, json, client/rsaPassword, std/[times, os], uri

type
  SteamClient* = object 
    httpclient*: HttpClient
    cookies*: HttpHeaders

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

proc getRSAKey(client: SteamClient,  username: string): RSAKey =
  ## Before authorization, you need to take the RSA PKCS15 Padding key & modulus exponent
  ## to encode the transmitted password for security
  let jsonObject = parseJson(client.httpclient.getContent("https://store.steampowered.com/login/getrsakey/?username="&($username)))
  result = to(jsonObject, RSAKey)
  return result 

proc doLogin(client: SteamClient, username, password, rsatimestamp, secret: string): string =
  let url = "https://steamcommunity.com/login/dologin/"
  var content = "donotcache=" & $(toUnix(toTime(now()))+150) & "000" & "&password=" & encodeUrl(password) & "&username=" & encodeUrl(username) & "&twofactorcode=" & secret & "&emailauth=&loginfriendlyname=&captchagid=-1&captcha_text=&emailsteamid=&rsatimestamp=" & rsatimestamp & "&remember_login=true"
  client.httpclient.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded"})
  let response = client.httpclient.request(url, HttpPost, body = content, client.httpclient.headers)
  return "\nBODY: " & response.body & "\n\nRESPONSE HEADERS: " & $response.headers & "\n\nCLIENT HEADERS: " & $client.httpclient.headers

proc auth*(client: SteamClient,  username: string, password: string, secret = ""): bool =
  var data_RSA = client.getRSAKey(username) 
  var encrypted_password = encryptPassword(data_RSA.publickey_mod, data_RSA.publickey_exp, password)
  echo client.doLogin(username, encrypted_password, data_RSA.timestamp, secret)
  return false
