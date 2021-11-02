import httpclient, base64, openssl, json

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
  ## Before authorization, you need to take the RSA key
  ## to encode the transmitted password for security
  let url = "https://store.steampowered.com/login/getrsakey/?username="&($username)
  let jsonObject = parseJson(client.httpclient.getContent(url))
  return to(jsonObject, RSAKey)

proc passwordEncode(publickey_mod: string, publickey_exp: string):string =
  #RSA_PKCS1_PADDING
  var prsa: PRSA
  
  return "kek"

# https://stackoverflow.com/questions/26822354/trying-to-pass-steam-auth-stumped-with-rsa-ecnryption-js-to-python

proc auth*(client: SteamClient,  username: string, password: string, secret: string): bool =
  ## TODO
  return false

