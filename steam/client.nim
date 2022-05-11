import httpclient, strutils, json, std/options, times, uri

include client/rsaPassword, client/iFuckedNonStaticJSONTypes

type
  SteamClient* = object 
    httpclient: HttpClient
    session: SessionData
    captcha_gid: string

  SessionData = object
    ga: string
    sessionid: string
    steamid: string
    steamCountry: string
    steamLoginSecure: string
    steamMachineAuth: string
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

proc getRSAKey(client: SteamClient,  username: string): RSAKey =
  ## Before authorization, you need to take the RSA PKCS15 Padding key & modulus exponent
  ## to encode the transmitted password for security
  let jsonObject = parseJson(client.httpclient.getContent("https://store.steampowered.com/login/getrsakey/?username="&($username)))
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

proc doLogin(client: SteamClient, username, password, rsatimestamp, secret, captcha_text: string): DoLoginResponse =
  let url = "https://steamcommunity.com/login/dologin/"
  let body = "donotcache=" & $(toUnix(toTime(now()))+150) & "000" & "&password=" & encodeUrl(password) & "&username=" & encodeUrl(username) & "&twofactorcode=" & secret & "&emailauth=&loginfriendlyname=&captchagid=-1&captcha_text=" & encodeUrl(captcha_text) & "&emailsteamid=&rsatimestamp=" & rsatimestamp & "&remember_login=true"
  client.httpclient.headers = newHttpHeaders({ "Content-Type": "application/x-www-form-urlencoded"})
  let response = client.httpclient.request(url, HttpPost, body = body, client.httpclient.headers)
  let jsonObject = parseJson(response.body)
  result = to(jsonObject, DoLoginResponse)
  echo response.headers
  echo result
  return result

proc auth*(client: SteamClient,  username: string, password: string, secret = "", captcha_text = ""): bool =
  let data_RSA = client.getRSAKey(username) 
  let encrypted_password = encryptPassword(data_RSA.publickey_mod, data_RSA.publickey_exp, password)
  let loginResponse = client.doLogin(username, encrypted_password, data_RSA.timestamp, secret, captcha_text)
  return loginResponse.success

proc commentProfile*(client: SteamClient, message: string, user_id: int64): bool =
  let url = "https://steamcommunity.com/comment/Profile/post/" & $user_id & "/-1/"
  let body = "comment=" & encodeUrl(message) & "&count=" & $(message.len) & "&sessionid=" & "!!!!!!!" & "&feature2=-1"
  return true