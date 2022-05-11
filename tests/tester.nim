import unittest

import steam, json

suite "unittests":
  echo "suite setup"
  
#   setup:
#     echo "Run (before test)"
  
#   teardown:
#     echo "Complete (after test)"
  
  test "webapi":
    var steamWebAPI = newSteamWebAPI()
    let jsonNode = steamWebAPI.call("ISteamWebAPIUtil","GetServerInfo", 1)
    doAssert jsonNode["servertime"].kind == JInt , "servertime jsonNode is failed"
    doAssert jsonNode["servertimestring"].kind == JString , "servertimestring jsonNode is failed"

  test "client auth request":
    var steamClient = newSteamClient()
    doAssert steamClient.auth("levshx", "WrongPassword", "WrongTwoFactorCode") == false, "what?"
    
  
  echo "Suite complete"



