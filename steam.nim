## 
## :Author: levshx
## :Version: 0.0.2
## This library allows you to use the open Web API Steam.
## 
##
## Overview
## ========
##
## Create WebAPI client
## -------------------
##
## Use only `var`
##
## .. code-block:: Nim
##   import steam/webapi
##
##   # input you Key Steam Web API
##   let keySteam = "XXXXYYYYZZZZDDDDAAAA1234"
##
##   # Create Steam session
##   var webAPI = newSteamWebAPI(keySteam) 
##
##
## Create Steam client
## -------------------
##
## Use only `var`
##
## .. code-block:: Nim
##   import steam/client
##
##   # Create Steam session
##   var steamClient = newSteamClient()
##   let auth = steamClient.auth("LOGIN", "PASSWORD", "2FA_KEY_OPTION", "CAPTHA_TEXT_OPTION") #bool
##   # let load = steamClient.loadSession("session.json") #bool
##
##   let save = steamClient.saveSession("session.json")
##   
##


import steam/webapi  
import steam/client  
import steam/features
export features
export webapi
export client