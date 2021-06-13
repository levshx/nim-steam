import ../steam, strutils

# input you Key Steam Web API
var clientSteam = newSteamClient("B78831E0C8B61A80B2342FDE1B109FFB") 

let testItems = clientSteam.getGameAssetPrices(730)
for item in testItems:
    echo clientSteam.getAssetClassInfo(730, parseBiggestInt(item.classid)).name
    echo "USD: "&($(item.prices.USD/100))

# OUTPUT:

# Prisma 2 Case Key
# USD: 2.49
# Shattered Web Case Key
# USD: 2.49
# CS20 Case Key
# USD: 2.49
# Prisma Case Key
# USD: 2.49
# Danger Zone Case Key
# USD: 2.49
# ... and more