import httpclient, json

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
    ## to encrypt the transmitted password for security
    let url = "https://store.steampowered.com/login/getrsakey/?username="&($username)
    let jsonObject = parseJson(client.httpclient.getContent(url))
    return to(jsonObject, RSAKey)


proc auth(client: SteamClient,  username: string, password: string, secret: string): bool =
    ## TODO
    return false


var client = newSteamClient()

echo client.getRSAKey("levshx")
