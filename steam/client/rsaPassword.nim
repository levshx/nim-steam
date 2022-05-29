import std/base64, strutils, bigints, std/random

# https://stackoverflow.com/questions/26822354/trying-to-pass-steam-auth-stumped-with-rsa-ecnryption-js-to-python
# https://github.com/igeligel/skadisteam.login/blob/master/src/skadisteam.login/Factories/EncryptPasswordFactory.cs


converter toSeqUint8(s: string): seq[uint8] = cast[seq[uint8]](s)

func bigInt2Hex(big_int: BigInt):string = 
  var bigInt = big_int  
  var resultSeq: seq[int]
  while (bigInt>0.initBigInt):
    resultSeq.add(parseInt($(bigInt mod 16.initBigInt))) 
    bigInt = bigInt div 16.initBigInt  
  for a in 0..(resultSeq.len-1):
    result.insert(resultSeq[a].toHex(1),0)
  return result

func hex2chars(hex_in: string): string =
  var hex = hex_in
  # Add null bits for parity
  while (hex.len mod 2 != 0):
    hex.add("0")
  doAssert hex.len mod 2 == 0
  for a in 0..((hex.len div 2)-1):
    result.add((char)fromHex[uint8]($hex[2*a] & $hex[2*a+1]))
  return result

proc pkcs1pad2(data:string, key_Size:int): BigInt =
  randomize()
  var keySize = key_Size
  if (keySize < data.len + 11):
      return initBigInt(0);

  var buffer: array[256, uint8]
  var i = data.len-1
  while (i >= 0 and keySize > 0):
    buffer[keySize-1] = (uint8)data[i]
    i = i - 1
    keySize = keySize - 1
            
  buffer[keySize-1] = 0
  keySize = keySize - 1

  while (keySize > 2):           
    buffer[keySize-1] = (uint8)rand(1..255)
    keySize = keySize - 1
              
  buffer[keySize-1] = 2
  keySize = keySize - 1
  buffer[keySize-1] = 0
  keySize = keySize - 1

  var bufferStr = ""
  for a in 0..(255):
    bufferStr.add(toHex(buffer[a]))

  var bufferBigInt = initBigInt(bufferStr, 16)
  return bufferBigInt

proc encryptPassword(publickey_mod: string, publickey_exp: string, password: string):string =

  var key_size = parseHexStr(publickey_mod).len
  doAssert keySize == (2048 + 7) shr 3
  let publickey_mod_bigint = initBigInt(publickey_mod, base = 16)
  let publickey_exp_bigint = initBigInt(publickey_exp, base = 16)

  var encryptedNumber = pkcs1pad2(password, key_size)

  encryptedNumber = powmod(encryptedNumber, publickey_exp_bigint, publickey_mod_bigint)

  var encryptedString = normalize(bigInt2Hex(encryptedNumber))

  var encryptedPassword = encode(hex2chars(encryptedString))

  return encryptedPassword

