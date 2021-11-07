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

proc passwordEncode(publickey_mod: string, publickey_exp: string, password: string):string =
  var rsa_pub: PRSA
  var public_key: string = """-----BEGIN PUBLIC KEY-----
  MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBALFj4XCZ2Cvb4vbPl0KJvkeFP8Lqit7q
  E1eA8US3ev/ziPlED5juC9IIBl69AOgxDHm1SjhceAxwG86Y8DkN7asCAwEAAQ==
  -----END PUBLIC KEY-----"""


  var bio_pub = BIO_new_mem_buf(addr publickey[0], -1)
  rsa_pub = PEM_read_bio_RSA_PUBKEY(bio_pub, rsa_pub.addr, nil, nil)

  if rsa_pub.isNil:
      echo "ERROR: Could not load PUBLIC KEY!  PEM_read_bio_RSA_PUBKEY FAILED"
      echo ERR_error_string(ERR_get_error(), nil)

  var plainText = "I love you"
  var cipherText = newString(RSA_size(rsa_pub))
  doAssert plainText.len < RSA_size(rsa_pub)-11
  let sz = RSA_public_encrypt(plainText.len.cint,plainText[0].addr,cipherText[0].addr,rsa_pub,RSA_PKCS1_PADDING)
  if sz != RSA_size(rsa_pub):
    echo "ERROR: RSA_public_encrypt FAILED!"
    echo ERR_error_string(ERR_get_error(),nil)
  return cipherText

# https://stackoverflow.com/questions/26822354/trying-to-pass-steam-auth-stumped-with-rsa-ecnryption-js-to-python

proc auth*(client: SteamClient,  username: string, password: string, secret: string): bool =
  ## TODO
  return false

