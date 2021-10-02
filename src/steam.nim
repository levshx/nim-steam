#
#            Nim's Runtime Library
#            Pavel Levshic
#

## This library allows you to use the open Web API Steam.
## 
##
## Overview
## ========
##
## Create Steam client
## ------------
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
## 
## Kek
##
## Test 
## --------------
##
## Test text
##

import steam/webapi  
import steam/client  

export webapi
export client