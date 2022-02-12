import std/[httpclient, json], strutils, json, client/rsaPassword, std/[times, os]

type
  SteamClient* = object 
    httpclient: HttpClient

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
  client.httpclient.headers = newHttpHeaders({ "Content-Type": "application/json" })
  let body = "donotcache=" & ($now()) & "&password=" & password & "&username=" & username & "&twofactorcode=" & secret & "&emailauth=&loginfriendlyname=&captchagid=-1&captcha_text=&emailsteamid=&rsatimestamp=" & rsatimestamp & "&remember_login=false"
  let response = client.httpclient.postContent(url, body = $body)
  return response 

proc auth*(client: SteamClient,  username: string, password: string, secret: string): bool =
  var data_RSA = client.getRSAKey(username) 
  var encrypted_password = encryptPassword(data_RSA.publickey_mod, data_RSA.publickey_exp, password)
  echo client.doLogin(username, encrypted_password, data_RSA.timestamp, secret)
  return false

