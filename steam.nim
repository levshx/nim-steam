## 
## :Author: levshx
## :Version: 0.0.2
## This library allows you to use the open Web API Steam.
## 
##
## Overview
## ========
##
## Create Steam client
## -------------------
##
## Use only `var`
##
## .. code-block:: Nim
##   import steam
##
##   # input you Key Steam Web API
##   let keySteam = "XXXXYYYYZZZZDDDDAAAA1234"
##
##   # Create Steam session
##   var clientSteam = newSteamWebAPI(keySteam) 


import steam/webapi  
import steam/client  
import steam/features
export features
export webapi
export client