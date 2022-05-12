import asyncdispatch, httpclient, uri, strutils, options
## :Author: levshx
## :Generated: 2022-05-12T17:29:07Z
const
  WEBAPI_BASE_URL* =
    when defined(ssl): "https://api.steampowered.com/" ## Steam API URL (SSL).
    else:              "http://api.steampowered.com/"  ## Steam API URL (No SSL).
type
  Rawbinary* = string
  Message* = string
  SteamWebAPI* = object
    ## Sync steam WebAPI client
    IClientStats_1046930*:IClientStats_1046930
    ICSGOPlayers_730*:ICSGOPlayers_730
    ICSGOServers_730*:ICSGOServers_730
    ICSGOTournaments_730*:ICSGOTournaments_730
    IDOTA2Fantasy_205790*:IDOTA2Fantasy_205790
    IDOTA2MatchStats_205790*:IDOTA2MatchStats_205790
    IDOTA2MatchStats_570*:IDOTA2MatchStats_570
    IDOTA2Match_205790*:IDOTA2Match_205790
    IDOTA2Match_570*:IDOTA2Match_570
    IDOTA2StreamSystem_205790*:IDOTA2StreamSystem_205790
    IDOTA2StreamSystem_570*:IDOTA2StreamSystem_570
    IDOTA2Ticket_205790*:IDOTA2Ticket_205790
    IDOTA2Ticket_570*:IDOTA2Ticket_570
    IEconDOTA2_205790*:IEconDOTA2_205790
    IEconDOTA2_570*:IEconDOTA2_570
    IEconItems_1046930*:IEconItems_1046930
    IEconItems_1269260*:IEconItems_1269260
    IEconItems_205790*:IEconItems_205790
    IEconItems_221540*:IEconItems_221540
    IEconItems_238460*:IEconItems_238460
    IEconItems_440*:IEconItems_440
    IEconItems_570*:IEconItems_570
    IEconItems_583950*:IEconItems_583950
    IEconItems_620*:IEconItems_620
    IEconItems_730*:IEconItems_730
    IGCVersion_1046930*:IGCVersion_1046930
    IGCVersion_1269260*:IGCVersion_1269260
    IGCVersion_205790*:IGCVersion_205790
    IGCVersion_440*:IGCVersion_440
    IGCVersion_570*:IGCVersion_570
    IGCVersion_583950*:IGCVersion_583950
    IGCVersion_730*:IGCVersion_730
    IPortal2Leaderboards_620*:IPortal2Leaderboards_620
    ISteamApps*:ISteamApps
    ISteamBroadcast*:ISteamBroadcast
    ISteamCDN*:ISteamCDN
    ISteamDirectory*:ISteamDirectory
    ISteamEconomy*:ISteamEconomy
    ISteamNews*:ISteamNews
    ISteamRemoteStorage*:ISteamRemoteStorage
    ISteamUser*:ISteamUser
    ISteamUserAuth*:ISteamUserAuth
    ISteamUserOAuth*:ISteamUserOAuth
    ISteamUserStats*:ISteamUserStats
    ISteamWebAPIUtil*:ISteamWebAPIUtil
    ISteamWebUserPresenceOAuth*:ISteamWebUserPresenceOAuth
    ITFItems_440*:ITFItems_440
    ITFPromos_205790*:ITFPromos_205790
    ITFPromos_440*:ITFPromos_440
    ITFPromos_620*:ITFPromos_620
    ITFSystem_440*:ITFSystem_440
    IGameServersService*:IGameServersService
    IPlayerService*:IPlayerService
    IBroadcastService*:IBroadcastService
    IContentServerConfigService*:IContentServerConfigService
    IContentServerDirectoryService*:IContentServerDirectoryService
    IPublishedFileService*:IPublishedFileService
    IEconService*:IEconService
    IGameNotificationsService*:IGameNotificationsService
    IInventoryService*:IInventoryService
    IStoreService*:IStoreService
    ICheatReportingService*:ICheatReportingService
  AsyncSteamWebAPI* = object
    ## Async steam WebAPI client
    IClientStats_1046930*: AsyncIClientStats_1046930
    ICSGOPlayers_730*: AsyncICSGOPlayers_730
    ICSGOServers_730*: AsyncICSGOServers_730
    ICSGOTournaments_730*: AsyncICSGOTournaments_730
    IDOTA2Fantasy_205790*: AsyncIDOTA2Fantasy_205790
    IDOTA2MatchStats_205790*: AsyncIDOTA2MatchStats_205790
    IDOTA2MatchStats_570*: AsyncIDOTA2MatchStats_570
    IDOTA2Match_205790*: AsyncIDOTA2Match_205790
    IDOTA2Match_570*: AsyncIDOTA2Match_570
    IDOTA2StreamSystem_205790*: AsyncIDOTA2StreamSystem_205790
    IDOTA2StreamSystem_570*: AsyncIDOTA2StreamSystem_570
    IDOTA2Ticket_205790*: AsyncIDOTA2Ticket_205790
    IDOTA2Ticket_570*: AsyncIDOTA2Ticket_570
    IEconDOTA2_205790*: AsyncIEconDOTA2_205790
    IEconDOTA2_570*: AsyncIEconDOTA2_570
    IEconItems_1046930*: AsyncIEconItems_1046930
    IEconItems_1269260*: AsyncIEconItems_1269260
    IEconItems_205790*: AsyncIEconItems_205790
    IEconItems_221540*: AsyncIEconItems_221540
    IEconItems_238460*: AsyncIEconItems_238460
    IEconItems_440*: AsyncIEconItems_440
    IEconItems_570*: AsyncIEconItems_570
    IEconItems_583950*: AsyncIEconItems_583950
    IEconItems_620*: AsyncIEconItems_620
    IEconItems_730*: AsyncIEconItems_730
    IGCVersion_1046930*: AsyncIGCVersion_1046930
    IGCVersion_1269260*: AsyncIGCVersion_1269260
    IGCVersion_205790*: AsyncIGCVersion_205790
    IGCVersion_440*: AsyncIGCVersion_440
    IGCVersion_570*: AsyncIGCVersion_570
    IGCVersion_583950*: AsyncIGCVersion_583950
    IGCVersion_730*: AsyncIGCVersion_730
    IPortal2Leaderboards_620*: AsyncIPortal2Leaderboards_620
    ISteamApps*: AsyncISteamApps
    ISteamBroadcast*: AsyncISteamBroadcast
    ISteamCDN*: AsyncISteamCDN
    ISteamDirectory*: AsyncISteamDirectory
    ISteamEconomy*: AsyncISteamEconomy
    ISteamNews*: AsyncISteamNews
    ISteamRemoteStorage*: AsyncISteamRemoteStorage
    ISteamUser*: AsyncISteamUser
    ISteamUserAuth*: AsyncISteamUserAuth
    ISteamUserOAuth*: AsyncISteamUserOAuth
    ISteamUserStats*: AsyncISteamUserStats
    ISteamWebAPIUtil*: AsyncISteamWebAPIUtil
    ISteamWebUserPresenceOAuth*: AsyncISteamWebUserPresenceOAuth
    ITFItems_440*: AsyncITFItems_440
    ITFPromos_205790*: AsyncITFPromos_205790
    ITFPromos_440*: AsyncITFPromos_440
    ITFPromos_620*: AsyncITFPromos_620
    ITFSystem_440*: AsyncITFSystem_440
    IGameServersService*: AsyncIGameServersService
    IPlayerService*: AsyncIPlayerService
    IBroadcastService*: AsyncIBroadcastService
    IContentServerConfigService*: AsyncIContentServerConfigService
    IContentServerDirectoryService*: AsyncIContentServerDirectoryService
    IPublishedFileService*: AsyncIPublishedFileService
    IEconService*: AsyncIEconService
    IGameNotificationsService*: AsyncIGameNotificationsService
    IInventoryService*: AsyncIInventoryService
    IStoreService*: AsyncIStoreService
    ICheatReportingService*: AsyncICheatReportingService
  IClientStats_1046930 = object 
    name*:string
    methods*: seq[string]
  AsyncIClientStats_1046930 =  object 
    name*:string
    methods*: seq[string]
  ICSGOPlayers_730 = object 
    name*:string
    methods*: seq[string]
  AsyncICSGOPlayers_730 =  object 
    name*:string
    methods*: seq[string]
  ICSGOServers_730 = object 
    name*:string
    methods*: seq[string]
  AsyncICSGOServers_730 =  object 
    name*:string
    methods*: seq[string]
  ICSGOTournaments_730 = object 
    name*:string
    methods*: seq[string]
  AsyncICSGOTournaments_730 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2Fantasy_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2Fantasy_205790 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2MatchStats_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2MatchStats_205790 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2MatchStats_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2MatchStats_570 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2Match_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2Match_205790 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2Match_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2Match_570 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2StreamSystem_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2StreamSystem_205790 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2StreamSystem_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2StreamSystem_570 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2Ticket_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2Ticket_205790 =  object 
    name*:string
    methods*: seq[string]
  IDOTA2Ticket_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIDOTA2Ticket_570 =  object 
    name*:string
    methods*: seq[string]
  IEconDOTA2_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconDOTA2_205790 =  object 
    name*:string
    methods*: seq[string]
  IEconDOTA2_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconDOTA2_570 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_1046930 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_1046930 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_1269260 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_1269260 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_205790 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_221540 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_221540 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_238460 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_238460 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_440 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_440 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_570 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_583950 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_583950 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_620 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_620 =  object 
    name*:string
    methods*: seq[string]
  IEconItems_730 = object 
    name*:string
    methods*: seq[string]
  AsyncIEconItems_730 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_1046930 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_1046930 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_1269260 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_1269260 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_205790 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_440 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_440 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_570 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_570 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_583950 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_583950 =  object 
    name*:string
    methods*: seq[string]
  IGCVersion_730 = object 
    name*:string
    methods*: seq[string]
  AsyncIGCVersion_730 =  object 
    name*:string
    methods*: seq[string]
  IPortal2Leaderboards_620 = object 
    name*:string
    methods*: seq[string]
  AsyncIPortal2Leaderboards_620 =  object 
    name*:string
    methods*: seq[string]
  ISteamApps = object 
    name*:string
    methods*: seq[string]
  AsyncISteamApps =  object 
    name*:string
    methods*: seq[string]
  ISteamBroadcast = object 
    name*:string
    methods*: seq[string]
  AsyncISteamBroadcast =  object 
    name*:string
    methods*: seq[string]
  ISteamCDN = object 
    name*:string
    methods*: seq[string]
  AsyncISteamCDN =  object 
    name*:string
    methods*: seq[string]
  ISteamDirectory = object 
    name*:string
    methods*: seq[string]
  AsyncISteamDirectory =  object 
    name*:string
    methods*: seq[string]
  ISteamEconomy = object 
    name*:string
    methods*: seq[string]
  AsyncISteamEconomy =  object 
    name*:string
    methods*: seq[string]
  ISteamNews = object 
    name*:string
    methods*: seq[string]
  AsyncISteamNews =  object 
    name*:string
    methods*: seq[string]
  ISteamRemoteStorage = object 
    name*:string
    methods*: seq[string]
  AsyncISteamRemoteStorage =  object 
    name*:string
    methods*: seq[string]
  ISteamUser = object 
    name*:string
    methods*: seq[string]
  AsyncISteamUser =  object 
    name*:string
    methods*: seq[string]
  ISteamUserAuth = object 
    name*:string
    methods*: seq[string]
  AsyncISteamUserAuth =  object 
    name*:string
    methods*: seq[string]
  ISteamUserOAuth = object 
    name*:string
    methods*: seq[string]
  AsyncISteamUserOAuth =  object 
    name*:string
    methods*: seq[string]
  ISteamUserStats = object 
    name*:string
    methods*: seq[string]
  AsyncISteamUserStats =  object 
    name*:string
    methods*: seq[string]
  ISteamWebAPIUtil = object 
    name*:string
    methods*: seq[string]
  AsyncISteamWebAPIUtil =  object 
    name*:string
    methods*: seq[string]
  ISteamWebUserPresenceOAuth = object 
    name*:string
    methods*: seq[string]
  AsyncISteamWebUserPresenceOAuth =  object 
    name*:string
    methods*: seq[string]
  ITFItems_440 = object 
    name*:string
    methods*: seq[string]
  AsyncITFItems_440 =  object 
    name*:string
    methods*: seq[string]
  ITFPromos_205790 = object 
    name*:string
    methods*: seq[string]
  AsyncITFPromos_205790 =  object 
    name*:string
    methods*: seq[string]
  ITFPromos_440 = object 
    name*:string
    methods*: seq[string]
  AsyncITFPromos_440 =  object 
    name*:string
    methods*: seq[string]
  ITFPromos_620 = object 
    name*:string
    methods*: seq[string]
  AsyncITFPromos_620 =  object 
    name*:string
    methods*: seq[string]
  ITFSystem_440 = object 
    name*:string
    methods*: seq[string]
  AsyncITFSystem_440 =  object 
    name*:string
    methods*: seq[string]
  IGameServersService = object 
    name*:string
    methods*: seq[string]
  AsyncIGameServersService =  object 
    name*:string
    methods*: seq[string]
  IPlayerService = object 
    name*:string
    methods*: seq[string]
  AsyncIPlayerService =  object 
    name*:string
    methods*: seq[string]
  IBroadcastService = object 
    name*:string
    methods*: seq[string]
  AsyncIBroadcastService =  object 
    name*:string
    methods*: seq[string]
  IContentServerConfigService = object 
    name*:string
    methods*: seq[string]
  AsyncIContentServerConfigService =  object 
    name*:string
    methods*: seq[string]
  IContentServerDirectoryService = object 
    name*:string
    methods*: seq[string]
  AsyncIContentServerDirectoryService =  object 
    name*:string
    methods*: seq[string]
  IPublishedFileService = object 
    name*:string
    methods*: seq[string]
  AsyncIPublishedFileService =  object 
    name*:string
    methods*: seq[string]
  IEconService = object 
    name*:string
    methods*: seq[string]
  AsyncIEconService =  object 
    name*:string
    methods*: seq[string]
  IGameNotificationsService = object 
    name*:string
    methods*: seq[string]
  AsyncIGameNotificationsService =  object 
    name*:string
    methods*: seq[string]
  IInventoryService = object 
    name*:string
    methods*: seq[string]
  AsyncIInventoryService =  object 
    name*:string
    methods*: seq[string]
  IStoreService = object 
    name*:string
    methods*: seq[string]
  AsyncIStoreService =  object 
    name*:string
    methods*: seq[string]
  ICheatReportingService = object 
    name*:string
    methods*: seq[string]
  AsyncICheatReportingService =  object 
    name*:string
    methods*: seq[string]

proc newSteamWebAPI*(): SteamWebAPI =
  result.IClientStats_1046930.name = "IClientStats_1046930"
  result.IClientStats_1046930.methods.add("ReportEvent:V1")
  result.ICSGOPlayers_730.name = "ICSGOPlayers_730"
  result.ICSGOPlayers_730.methods.add("GetNextMatchSharingCode:V1")
  result.ICSGOServers_730.name = "ICSGOServers_730"
  result.ICSGOServers_730.methods.add("GetGameMapsPlaytime:V1")
  result.ICSGOServers_730.methods.add("GetGameServersStatus:V1")
  result.ICSGOTournaments_730.name = "ICSGOTournaments_730"
  result.ICSGOTournaments_730.methods.add("GetTournamentFantasyLineup:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentItems:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentLayout:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentPredictions:V1")
  result.ICSGOTournaments_730.methods.add("UploadTournamentFantasyLineup:V1")
  result.ICSGOTournaments_730.methods.add("UploadTournamentPredictions:V1")
  result.IDOTA2Fantasy_205790.name = "IDOTA2Fantasy_205790"
  result.IDOTA2Fantasy_205790.methods.add("GetFantasyPlayerStats:V1")
  result.IDOTA2Fantasy_205790.methods.add("GetPlayerOfficialInfo:V1")
  result.IDOTA2Fantasy_205790.methods.add("GetProPlayerList:V1")
  result.IDOTA2MatchStats_205790.name = "IDOTA2MatchStats_205790"
  result.IDOTA2MatchStats_205790.methods.add("GetRealtimeStats:V1")
  result.IDOTA2MatchStats_570.name = "IDOTA2MatchStats_570"
  result.IDOTA2MatchStats_570.methods.add("GetRealtimeStats:V1")
  result.IDOTA2Match_205790.name = "IDOTA2Match_205790"
  result.IDOTA2Match_205790.methods.add("GetLeagueListing:V1")
  result.IDOTA2Match_205790.methods.add("GetLiveLeagueGames:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchDetails:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchHistory:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchHistoryBySequenceNum:V1")
  result.IDOTA2Match_205790.methods.add("GetTeamInfoByTeamID:V1")
  result.IDOTA2Match_205790.methods.add("GetTopLiveEventGame:V1")
  result.IDOTA2Match_205790.methods.add("GetTopLiveGame:V1")
  result.IDOTA2Match_205790.methods.add("GetTopWeekendTourneyGames:V1")
  result.IDOTA2Match_205790.methods.add("GetTournamentPlayerStats:V1")
  result.IDOTA2Match_205790.methods.add("GetTournamentPlayerStats:V2")
  result.IDOTA2Match_570.name = "IDOTA2Match_570"
  result.IDOTA2Match_570.methods.add("GetLiveLeagueGames:V1")
  result.IDOTA2Match_570.methods.add("GetMatchDetails:V1")
  result.IDOTA2Match_570.methods.add("GetMatchHistory:V1")
  result.IDOTA2Match_570.methods.add("GetMatchHistoryBySequenceNum:V1")
  result.IDOTA2Match_570.methods.add("GetTeamInfoByTeamID:V1")
  result.IDOTA2Match_570.methods.add("GetTopLiveEventGame:V1")
  result.IDOTA2Match_570.methods.add("GetTopLiveGame:V1")
  result.IDOTA2Match_570.methods.add("GetTopWeekendTourneyGames:V1")
  result.IDOTA2Match_570.methods.add("GetTournamentPlayerStats:V1")
  result.IDOTA2Match_570.methods.add("GetTournamentPlayerStats:V2")
  result.IDOTA2StreamSystem_205790.name = "IDOTA2StreamSystem_205790"
  result.IDOTA2StreamSystem_205790.methods.add("GetBroadcasterInfo:V1")
  result.IDOTA2StreamSystem_570.name = "IDOTA2StreamSystem_570"
  result.IDOTA2StreamSystem_570.methods.add("GetBroadcasterInfo:V1")
  result.IDOTA2Ticket_205790.name = "IDOTA2Ticket_205790"
  result.IDOTA2Ticket_205790.methods.add("ClaimBadgeReward:V1")
  result.IDOTA2Ticket_205790.methods.add("GetSteamIDForBadgeID:V1")
  result.IDOTA2Ticket_205790.methods.add("SetSteamAccountPurchased:V1")
  result.IDOTA2Ticket_205790.methods.add("SteamAccountValidForBadgeType:V1")
  result.IDOTA2Ticket_570.name = "IDOTA2Ticket_570"
  result.IDOTA2Ticket_570.methods.add("SetSteamAccountPurchased:V1")
  result.IDOTA2Ticket_570.methods.add("SteamAccountValidForBadgeType:V1")
  result.IEconDOTA2_205790.name = "IEconDOTA2_205790"
  result.IEconDOTA2_205790.methods.add("GetEventStatsForAccount:V1")
  result.IEconDOTA2_205790.methods.add("GetGameItems:V1")
  result.IEconDOTA2_205790.methods.add("GetHeroes:V1")
  result.IEconDOTA2_205790.methods.add("GetItemIconPath:V1")
  result.IEconDOTA2_205790.methods.add("GetRarities:V1")
  result.IEconDOTA2_205790.methods.add("GetTournamentPrizePool:V1")
  result.IEconDOTA2_570.name = "IEconDOTA2_570"
  result.IEconDOTA2_570.methods.add("GetEventStatsForAccount:V1")
  result.IEconDOTA2_570.methods.add("GetGameItems:V1")
  result.IEconDOTA2_570.methods.add("GetHeroes:V1")
  result.IEconDOTA2_570.methods.add("GetItemCreators:V1")
  result.IEconDOTA2_570.methods.add("GetItemWorkshopPublishedFileIDs:V1")
  result.IEconDOTA2_570.methods.add("GetRarities:V1")
  result.IEconDOTA2_570.methods.add("GetTournamentPrizePool:V1")
  result.IEconItems_1046930.name = "IEconItems_1046930"
  result.IEconItems_1046930.methods.add("GetPlayerItems:V1")
  result.IEconItems_1269260.name = "IEconItems_1269260"
  result.IEconItems_1269260.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_205790.name = "IEconItems_205790"
  result.IEconItems_205790.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_205790.methods.add("GetPlayerItems:V1")
  result.IEconItems_205790.methods.add("GetSchemaURL:V1")
  result.IEconItems_205790.methods.add("GetStoreMetaData:V1")
  result.IEconItems_221540.name = "IEconItems_221540"
  result.IEconItems_221540.methods.add("GetPlayerItems:V1")
  result.IEconItems_238460.name = "IEconItems_238460"
  result.IEconItems_238460.methods.add("GetPlayerItems:V1")
  result.IEconItems_440.name = "IEconItems_440"
  result.IEconItems_440.methods.add("GetPlayerItems:V1")
  result.IEconItems_440.methods.add("GetSchema:V1")
  result.IEconItems_440.methods.add("GetSchemaItems:V1")
  result.IEconItems_440.methods.add("GetSchemaOverview:V1")
  result.IEconItems_440.methods.add("GetSchemaURL:V1")
  result.IEconItems_440.methods.add("GetStoreMetaData:V1")
  result.IEconItems_440.methods.add("GetStoreStatus:V1")
  result.IEconItems_570.name = "IEconItems_570"
  result.IEconItems_570.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_570.methods.add("GetPlayerItems:V1")
  result.IEconItems_570.methods.add("GetStoreMetaData:V1")
  result.IEconItems_583950.name = "IEconItems_583950"
  result.IEconItems_583950.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_620.name = "IEconItems_620"
  result.IEconItems_620.methods.add("GetPlayerItems:V1")
  result.IEconItems_620.methods.add("GetSchema:V1")
  result.IEconItems_730.name = "IEconItems_730"
  result.IEconItems_730.methods.add("GetPlayerItems:V1")
  result.IEconItems_730.methods.add("GetSchema:V2")
  result.IEconItems_730.methods.add("GetSchemaURL:V2")
  result.IEconItems_730.methods.add("GetStoreMetaData:V1")
  result.IGCVersion_1046930.name = "IGCVersion_1046930"
  result.IGCVersion_1046930.methods.add("GetClientVersion:V1")
  result.IGCVersion_1046930.methods.add("GetServerVersion:V1")
  result.IGCVersion_1269260.name = "IGCVersion_1269260"
  result.IGCVersion_1269260.methods.add("GetClientVersion:V1")
  result.IGCVersion_1269260.methods.add("GetServerVersion:V1")
  result.IGCVersion_205790.name = "IGCVersion_205790"
  result.IGCVersion_205790.methods.add("GetClientVersion:V1")
  result.IGCVersion_205790.methods.add("GetServerVersion:V1")
  result.IGCVersion_440.name = "IGCVersion_440"
  result.IGCVersion_440.methods.add("GetClientVersion:V1")
  result.IGCVersion_440.methods.add("GetServerVersion:V1")
  result.IGCVersion_570.name = "IGCVersion_570"
  result.IGCVersion_570.methods.add("GetClientVersion:V1")
  result.IGCVersion_570.methods.add("GetServerVersion:V1")
  result.IGCVersion_583950.name = "IGCVersion_583950"
  result.IGCVersion_583950.methods.add("GetClientVersion:V1")
  result.IGCVersion_583950.methods.add("GetServerVersion:V1")
  result.IGCVersion_730.name = "IGCVersion_730"
  result.IGCVersion_730.methods.add("GetServerVersion:V1")
  result.IPortal2Leaderboards_620.name = "IPortal2Leaderboards_620"
  result.IPortal2Leaderboards_620.methods.add("GetBucketizedData:V1")
  result.ISteamApps.name = "ISteamApps"
  result.ISteamApps.methods.add("GetAppList:V1")
  result.ISteamApps.methods.add("GetAppList:V2")
  result.ISteamApps.methods.add("GetSDRConfig:V1")
  result.ISteamApps.methods.add("GetServersAtAddress:V1")
  result.ISteamApps.methods.add("UpToDateCheck:V1")
  result.ISteamBroadcast.name = "ISteamBroadcast"
  result.ISteamBroadcast.methods.add("ViewerHeartbeat:V1")
  result.ISteamCDN.name = "ISteamCDN"
  result.ISteamCDN.methods.add("SetClientFilters:V1")
  result.ISteamCDN.methods.add("SetPerformanceStats:V1")
  result.ISteamDirectory.name = "ISteamDirectory"
  result.ISteamDirectory.methods.add("GetCMList:V1")
  result.ISteamDirectory.methods.add("GetCMListForConnect:V1")
  result.ISteamDirectory.methods.add("GetSteamPipeDomains:V1")
  result.ISteamEconomy.name = "ISteamEconomy"
  result.ISteamEconomy.methods.add("GetAssetClassInfo:V1")
  result.ISteamEconomy.methods.add("GetAssetPrices:V1")
  result.ISteamNews.name = "ISteamNews"
  result.ISteamNews.methods.add("GetNewsForApp:V1")
  result.ISteamNews.methods.add("GetNewsForApp:V2")
  result.ISteamRemoteStorage.name = "ISteamRemoteStorage"
  result.ISteamRemoteStorage.methods.add("GetCollectionDetails:V1")
  result.ISteamRemoteStorage.methods.add("GetPublishedFileDetails:V1")
  result.ISteamRemoteStorage.methods.add("GetUGCFileDetails:V1")
  result.ISteamUser.name = "ISteamUser"
  result.ISteamUser.methods.add("GetFriendList:V1")
  result.ISteamUser.methods.add("GetPlayerBans:V1")
  result.ISteamUser.methods.add("GetPlayerSummaries:V1")
  result.ISteamUser.methods.add("GetPlayerSummaries:V2")
  result.ISteamUser.methods.add("GetUserGroupList:V1")
  result.ISteamUser.methods.add("ResolveVanityURL:V1")
  result.ISteamUserAuth.name = "ISteamUserAuth"
  result.ISteamUserAuth.methods.add("AuthenticateUser:V1")
  result.ISteamUserAuth.methods.add("AuthenticateUserTicket:V1")
  result.ISteamUserOAuth.name = "ISteamUserOAuth"
  result.ISteamUserOAuth.methods.add("GetTokenDetails:V1")
  result.ISteamUserStats.name = "ISteamUserStats"
  result.ISteamUserStats.methods.add("GetGlobalAchievementPercentagesForApp:V1")
  result.ISteamUserStats.methods.add("GetGlobalAchievementPercentagesForApp:V2")
  result.ISteamUserStats.methods.add("GetGlobalStatsForGame:V1")
  result.ISteamUserStats.methods.add("GetNumberOfCurrentPlayers:V1")
  result.ISteamUserStats.methods.add("GetPlayerAchievements:V1")
  result.ISteamUserStats.methods.add("GetSchemaForGame:V1")
  result.ISteamUserStats.methods.add("GetSchemaForGame:V2")
  result.ISteamUserStats.methods.add("GetUserStatsForGame:V1")
  result.ISteamUserStats.methods.add("GetUserStatsForGame:V2")
  result.ISteamWebAPIUtil.name = "ISteamWebAPIUtil"
  result.ISteamWebAPIUtil.methods.add("GetServerInfo:V1")
  result.ISteamWebAPIUtil.methods.add("GetSupportedAPIList:V1")
  result.ISteamWebUserPresenceOAuth.name = "ISteamWebUserPresenceOAuth"
  result.ISteamWebUserPresenceOAuth.methods.add("PollStatus:V1")
  result.ITFItems_440.name = "ITFItems_440"
  result.ITFItems_440.methods.add("GetGoldenWrenches:V1")
  result.ITFItems_440.methods.add("GetGoldenWrenches:V2")
  result.ITFPromos_205790.name = "ITFPromos_205790"
  result.ITFPromos_205790.methods.add("GetItemID:V1")
  result.ITFPromos_205790.methods.add("GrantItem:V1")
  result.ITFPromos_440.name = "ITFPromos_440"
  result.ITFPromos_440.methods.add("GetItemID:V1")
  result.ITFPromos_440.methods.add("GrantItem:V1")
  result.ITFPromos_620.name = "ITFPromos_620"
  result.ITFPromos_620.methods.add("GetItemID:V1")
  result.ITFPromos_620.methods.add("GrantItem:V1")
  result.ITFSystem_440.name = "ITFSystem_440"
  result.ITFSystem_440.methods.add("GetWorldStatus:V1")
  result.IGameServersService.name = "IGameServersService"
  result.IGameServersService.methods.add("GetAccountList:V1")
  result.IGameServersService.methods.add("CreateAccount:V1")
  result.IGameServersService.methods.add("SetMemo:V1")
  result.IGameServersService.methods.add("ResetLoginToken:V1")
  result.IGameServersService.methods.add("DeleteAccount:V1")
  result.IGameServersService.methods.add("GetAccountPublicInfo:V1")
  result.IGameServersService.methods.add("QueryLoginToken:V1")
  result.IGameServersService.methods.add("GetServerSteamIDsByIP:V1")
  result.IGameServersService.methods.add("GetServerIPsBySteamID:V1")
  result.IGameServersService.methods.add("QueryByFakeIP:V1")
  result.IPlayerService.name = "IPlayerService"
  result.IPlayerService.methods.add("IsPlayingSharedGame:V1")
  result.IPlayerService.methods.add("RecordOfflinePlaytime:V1")
  result.IPlayerService.methods.add("GetRecentlyPlayedGames:V1")
  result.IPlayerService.methods.add("GetOwnedGames:V1")
  result.IPlayerService.methods.add("GetSteamLevel:V1")
  result.IPlayerService.methods.add("GetBadges:V1")
  result.IPlayerService.methods.add("GetCommunityBadgeProgress:V1")
  result.IBroadcastService.name = "IBroadcastService"
  result.IBroadcastService.methods.add("PostGameDataFrameRTMP:V1")
  result.IContentServerConfigService.name = "IContentServerConfigService"
  result.IContentServerConfigService.methods.add("SetSteamCacheClientFilters:V1")
  result.IContentServerConfigService.methods.add("GetSteamCacheNodeParams:V1")
  result.IContentServerConfigService.methods.add("SetSteamCachePerformanceStats:V1")
  result.IContentServerDirectoryService.name = "IContentServerDirectoryService"
  result.IContentServerDirectoryService.methods.add("GetServersForSteamPipe:V1")
  result.IContentServerDirectoryService.methods.add("GetClientUpdateHosts:V1")
  result.IContentServerDirectoryService.methods.add("GetDepotPatchInfo:V1")
  result.IPublishedFileService.name = "IPublishedFileService"
  result.IPublishedFileService.methods.add("GetUserVoteSummary:V1")
  result.IPublishedFileService.methods.add("QueryFiles:V1")
  result.IPublishedFileService.methods.add("GetDetails:V1")
  result.IPublishedFileService.methods.add("GetUserFiles:V1")
  result.IEconService.name = "IEconService"
  result.IEconService.methods.add("GetTradeHistory:V1")
  result.IEconService.methods.add("GetTradeStatus:V1")
  result.IEconService.methods.add("GetTradeOffers:V1")
  result.IEconService.methods.add("GetTradeOffer:V1")
  result.IEconService.methods.add("GetTradeOffersSummary:V1")
  result.IEconService.methods.add("GetTradeHoldDurations:V1")
  result.IGameNotificationsService.name = "IGameNotificationsService"
  result.IGameNotificationsService.methods.add("UserCreateSession:V1")
  result.IGameNotificationsService.methods.add("UserUpdateSession:V1")
  result.IGameNotificationsService.methods.add("UserDeleteSession:V1")
  result.IInventoryService.name = "IInventoryService"
  result.IInventoryService.methods.add("SplitItemStack:V1")
  result.IInventoryService.methods.add("CombineItemStacks:V1")
  result.IInventoryService.methods.add("GetPriceSheet:V1")
  result.IStoreService.name = "IStoreService"
  result.IStoreService.methods.add("GetAppList:V1")
  result.ICheatReportingService.name = "ICheatReportingService"
  result.ICheatReportingService.methods.add("ReportCheatData:V1")
  return result


proc newAsyncSteamWebAPI*(): AsyncSteamWebAPI =
  result.IClientStats_1046930.name = "IClientStats_1046930"
  result.IClientStats_1046930.methods.add("ReportEvent:V1")
  result.ICSGOPlayers_730.name = "ICSGOPlayers_730"
  result.ICSGOPlayers_730.methods.add("GetNextMatchSharingCode:V1")
  result.ICSGOServers_730.name = "ICSGOServers_730"
  result.ICSGOServers_730.methods.add("GetGameMapsPlaytime:V1")
  result.ICSGOServers_730.methods.add("GetGameServersStatus:V1")
  result.ICSGOTournaments_730.name = "ICSGOTournaments_730"
  result.ICSGOTournaments_730.methods.add("GetTournamentFantasyLineup:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentItems:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentLayout:V1")
  result.ICSGOTournaments_730.methods.add("GetTournamentPredictions:V1")
  result.ICSGOTournaments_730.methods.add("UploadTournamentFantasyLineup:V1")
  result.ICSGOTournaments_730.methods.add("UploadTournamentPredictions:V1")
  result.IDOTA2Fantasy_205790.name = "IDOTA2Fantasy_205790"
  result.IDOTA2Fantasy_205790.methods.add("GetFantasyPlayerStats:V1")
  result.IDOTA2Fantasy_205790.methods.add("GetPlayerOfficialInfo:V1")
  result.IDOTA2Fantasy_205790.methods.add("GetProPlayerList:V1")
  result.IDOTA2MatchStats_205790.name = "IDOTA2MatchStats_205790"
  result.IDOTA2MatchStats_205790.methods.add("GetRealtimeStats:V1")
  result.IDOTA2MatchStats_570.name = "IDOTA2MatchStats_570"
  result.IDOTA2MatchStats_570.methods.add("GetRealtimeStats:V1")
  result.IDOTA2Match_205790.name = "IDOTA2Match_205790"
  result.IDOTA2Match_205790.methods.add("GetLeagueListing:V1")
  result.IDOTA2Match_205790.methods.add("GetLiveLeagueGames:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchDetails:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchHistory:V1")
  result.IDOTA2Match_205790.methods.add("GetMatchHistoryBySequenceNum:V1")
  result.IDOTA2Match_205790.methods.add("GetTeamInfoByTeamID:V1")
  result.IDOTA2Match_205790.methods.add("GetTopLiveEventGame:V1")
  result.IDOTA2Match_205790.methods.add("GetTopLiveGame:V1")
  result.IDOTA2Match_205790.methods.add("GetTopWeekendTourneyGames:V1")
  result.IDOTA2Match_205790.methods.add("GetTournamentPlayerStats:V1")
  result.IDOTA2Match_205790.methods.add("GetTournamentPlayerStats:V2")
  result.IDOTA2Match_570.name = "IDOTA2Match_570"
  result.IDOTA2Match_570.methods.add("GetLiveLeagueGames:V1")
  result.IDOTA2Match_570.methods.add("GetMatchDetails:V1")
  result.IDOTA2Match_570.methods.add("GetMatchHistory:V1")
  result.IDOTA2Match_570.methods.add("GetMatchHistoryBySequenceNum:V1")
  result.IDOTA2Match_570.methods.add("GetTeamInfoByTeamID:V1")
  result.IDOTA2Match_570.methods.add("GetTopLiveEventGame:V1")
  result.IDOTA2Match_570.methods.add("GetTopLiveGame:V1")
  result.IDOTA2Match_570.methods.add("GetTopWeekendTourneyGames:V1")
  result.IDOTA2Match_570.methods.add("GetTournamentPlayerStats:V1")
  result.IDOTA2Match_570.methods.add("GetTournamentPlayerStats:V2")
  result.IDOTA2StreamSystem_205790.name = "IDOTA2StreamSystem_205790"
  result.IDOTA2StreamSystem_205790.methods.add("GetBroadcasterInfo:V1")
  result.IDOTA2StreamSystem_570.name = "IDOTA2StreamSystem_570"
  result.IDOTA2StreamSystem_570.methods.add("GetBroadcasterInfo:V1")
  result.IDOTA2Ticket_205790.name = "IDOTA2Ticket_205790"
  result.IDOTA2Ticket_205790.methods.add("ClaimBadgeReward:V1")
  result.IDOTA2Ticket_205790.methods.add("GetSteamIDForBadgeID:V1")
  result.IDOTA2Ticket_205790.methods.add("SetSteamAccountPurchased:V1")
  result.IDOTA2Ticket_205790.methods.add("SteamAccountValidForBadgeType:V1")
  result.IDOTA2Ticket_570.name = "IDOTA2Ticket_570"
  result.IDOTA2Ticket_570.methods.add("SetSteamAccountPurchased:V1")
  result.IDOTA2Ticket_570.methods.add("SteamAccountValidForBadgeType:V1")
  result.IEconDOTA2_205790.name = "IEconDOTA2_205790"
  result.IEconDOTA2_205790.methods.add("GetEventStatsForAccount:V1")
  result.IEconDOTA2_205790.methods.add("GetGameItems:V1")
  result.IEconDOTA2_205790.methods.add("GetHeroes:V1")
  result.IEconDOTA2_205790.methods.add("GetItemIconPath:V1")
  result.IEconDOTA2_205790.methods.add("GetRarities:V1")
  result.IEconDOTA2_205790.methods.add("GetTournamentPrizePool:V1")
  result.IEconDOTA2_570.name = "IEconDOTA2_570"
  result.IEconDOTA2_570.methods.add("GetEventStatsForAccount:V1")
  result.IEconDOTA2_570.methods.add("GetGameItems:V1")
  result.IEconDOTA2_570.methods.add("GetHeroes:V1")
  result.IEconDOTA2_570.methods.add("GetItemCreators:V1")
  result.IEconDOTA2_570.methods.add("GetItemWorkshopPublishedFileIDs:V1")
  result.IEconDOTA2_570.methods.add("GetRarities:V1")
  result.IEconDOTA2_570.methods.add("GetTournamentPrizePool:V1")
  result.IEconItems_1046930.name = "IEconItems_1046930"
  result.IEconItems_1046930.methods.add("GetPlayerItems:V1")
  result.IEconItems_1269260.name = "IEconItems_1269260"
  result.IEconItems_1269260.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_205790.name = "IEconItems_205790"
  result.IEconItems_205790.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_205790.methods.add("GetPlayerItems:V1")
  result.IEconItems_205790.methods.add("GetSchemaURL:V1")
  result.IEconItems_205790.methods.add("GetStoreMetaData:V1")
  result.IEconItems_221540.name = "IEconItems_221540"
  result.IEconItems_221540.methods.add("GetPlayerItems:V1")
  result.IEconItems_238460.name = "IEconItems_238460"
  result.IEconItems_238460.methods.add("GetPlayerItems:V1")
  result.IEconItems_440.name = "IEconItems_440"
  result.IEconItems_440.methods.add("GetPlayerItems:V1")
  result.IEconItems_440.methods.add("GetSchema:V1")
  result.IEconItems_440.methods.add("GetSchemaItems:V1")
  result.IEconItems_440.methods.add("GetSchemaOverview:V1")
  result.IEconItems_440.methods.add("GetSchemaURL:V1")
  result.IEconItems_440.methods.add("GetStoreMetaData:V1")
  result.IEconItems_440.methods.add("GetStoreStatus:V1")
  result.IEconItems_570.name = "IEconItems_570"
  result.IEconItems_570.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_570.methods.add("GetPlayerItems:V1")
  result.IEconItems_570.methods.add("GetStoreMetaData:V1")
  result.IEconItems_583950.name = "IEconItems_583950"
  result.IEconItems_583950.methods.add("GetEquippedPlayerItems:V1")
  result.IEconItems_620.name = "IEconItems_620"
  result.IEconItems_620.methods.add("GetPlayerItems:V1")
  result.IEconItems_620.methods.add("GetSchema:V1")
  result.IEconItems_730.name = "IEconItems_730"
  result.IEconItems_730.methods.add("GetPlayerItems:V1")
  result.IEconItems_730.methods.add("GetSchema:V2")
  result.IEconItems_730.methods.add("GetSchemaURL:V2")
  result.IEconItems_730.methods.add("GetStoreMetaData:V1")
  result.IGCVersion_1046930.name = "IGCVersion_1046930"
  result.IGCVersion_1046930.methods.add("GetClientVersion:V1")
  result.IGCVersion_1046930.methods.add("GetServerVersion:V1")
  result.IGCVersion_1269260.name = "IGCVersion_1269260"
  result.IGCVersion_1269260.methods.add("GetClientVersion:V1")
  result.IGCVersion_1269260.methods.add("GetServerVersion:V1")
  result.IGCVersion_205790.name = "IGCVersion_205790"
  result.IGCVersion_205790.methods.add("GetClientVersion:V1")
  result.IGCVersion_205790.methods.add("GetServerVersion:V1")
  result.IGCVersion_440.name = "IGCVersion_440"
  result.IGCVersion_440.methods.add("GetClientVersion:V1")
  result.IGCVersion_440.methods.add("GetServerVersion:V1")
  result.IGCVersion_570.name = "IGCVersion_570"
  result.IGCVersion_570.methods.add("GetClientVersion:V1")
  result.IGCVersion_570.methods.add("GetServerVersion:V1")
  result.IGCVersion_583950.name = "IGCVersion_583950"
  result.IGCVersion_583950.methods.add("GetClientVersion:V1")
  result.IGCVersion_583950.methods.add("GetServerVersion:V1")
  result.IGCVersion_730.name = "IGCVersion_730"
  result.IGCVersion_730.methods.add("GetServerVersion:V1")
  result.IPortal2Leaderboards_620.name = "IPortal2Leaderboards_620"
  result.IPortal2Leaderboards_620.methods.add("GetBucketizedData:V1")
  result.ISteamApps.name = "ISteamApps"
  result.ISteamApps.methods.add("GetAppList:V1")
  result.ISteamApps.methods.add("GetAppList:V2")
  result.ISteamApps.methods.add("GetSDRConfig:V1")
  result.ISteamApps.methods.add("GetServersAtAddress:V1")
  result.ISteamApps.methods.add("UpToDateCheck:V1")
  result.ISteamBroadcast.name = "ISteamBroadcast"
  result.ISteamBroadcast.methods.add("ViewerHeartbeat:V1")
  result.ISteamCDN.name = "ISteamCDN"
  result.ISteamCDN.methods.add("SetClientFilters:V1")
  result.ISteamCDN.methods.add("SetPerformanceStats:V1")
  result.ISteamDirectory.name = "ISteamDirectory"
  result.ISteamDirectory.methods.add("GetCMList:V1")
  result.ISteamDirectory.methods.add("GetCMListForConnect:V1")
  result.ISteamDirectory.methods.add("GetSteamPipeDomains:V1")
  result.ISteamEconomy.name = "ISteamEconomy"
  result.ISteamEconomy.methods.add("GetAssetClassInfo:V1")
  result.ISteamEconomy.methods.add("GetAssetPrices:V1")
  result.ISteamNews.name = "ISteamNews"
  result.ISteamNews.methods.add("GetNewsForApp:V1")
  result.ISteamNews.methods.add("GetNewsForApp:V2")
  result.ISteamRemoteStorage.name = "ISteamRemoteStorage"
  result.ISteamRemoteStorage.methods.add("GetCollectionDetails:V1")
  result.ISteamRemoteStorage.methods.add("GetPublishedFileDetails:V1")
  result.ISteamRemoteStorage.methods.add("GetUGCFileDetails:V1")
  result.ISteamUser.name = "ISteamUser"
  result.ISteamUser.methods.add("GetFriendList:V1")
  result.ISteamUser.methods.add("GetPlayerBans:V1")
  result.ISteamUser.methods.add("GetPlayerSummaries:V1")
  result.ISteamUser.methods.add("GetPlayerSummaries:V2")
  result.ISteamUser.methods.add("GetUserGroupList:V1")
  result.ISteamUser.methods.add("ResolveVanityURL:V1")
  result.ISteamUserAuth.name = "ISteamUserAuth"
  result.ISteamUserAuth.methods.add("AuthenticateUser:V1")
  result.ISteamUserAuth.methods.add("AuthenticateUserTicket:V1")
  result.ISteamUserOAuth.name = "ISteamUserOAuth"
  result.ISteamUserOAuth.methods.add("GetTokenDetails:V1")
  result.ISteamUserStats.name = "ISteamUserStats"
  result.ISteamUserStats.methods.add("GetGlobalAchievementPercentagesForApp:V1")
  result.ISteamUserStats.methods.add("GetGlobalAchievementPercentagesForApp:V2")
  result.ISteamUserStats.methods.add("GetGlobalStatsForGame:V1")
  result.ISteamUserStats.methods.add("GetNumberOfCurrentPlayers:V1")
  result.ISteamUserStats.methods.add("GetPlayerAchievements:V1")
  result.ISteamUserStats.methods.add("GetSchemaForGame:V1")
  result.ISteamUserStats.methods.add("GetSchemaForGame:V2")
  result.ISteamUserStats.methods.add("GetUserStatsForGame:V1")
  result.ISteamUserStats.methods.add("GetUserStatsForGame:V2")
  result.ISteamWebAPIUtil.name = "ISteamWebAPIUtil"
  result.ISteamWebAPIUtil.methods.add("GetServerInfo:V1")
  result.ISteamWebAPIUtil.methods.add("GetSupportedAPIList:V1")
  result.ISteamWebUserPresenceOAuth.name = "ISteamWebUserPresenceOAuth"
  result.ISteamWebUserPresenceOAuth.methods.add("PollStatus:V1")
  result.ITFItems_440.name = "ITFItems_440"
  result.ITFItems_440.methods.add("GetGoldenWrenches:V1")
  result.ITFItems_440.methods.add("GetGoldenWrenches:V2")
  result.ITFPromos_205790.name = "ITFPromos_205790"
  result.ITFPromos_205790.methods.add("GetItemID:V1")
  result.ITFPromos_205790.methods.add("GrantItem:V1")
  result.ITFPromos_440.name = "ITFPromos_440"
  result.ITFPromos_440.methods.add("GetItemID:V1")
  result.ITFPromos_440.methods.add("GrantItem:V1")
  result.ITFPromos_620.name = "ITFPromos_620"
  result.ITFPromos_620.methods.add("GetItemID:V1")
  result.ITFPromos_620.methods.add("GrantItem:V1")
  result.ITFSystem_440.name = "ITFSystem_440"
  result.ITFSystem_440.methods.add("GetWorldStatus:V1")
  result.IGameServersService.name = "IGameServersService"
  result.IGameServersService.methods.add("GetAccountList:V1")
  result.IGameServersService.methods.add("CreateAccount:V1")
  result.IGameServersService.methods.add("SetMemo:V1")
  result.IGameServersService.methods.add("ResetLoginToken:V1")
  result.IGameServersService.methods.add("DeleteAccount:V1")
  result.IGameServersService.methods.add("GetAccountPublicInfo:V1")
  result.IGameServersService.methods.add("QueryLoginToken:V1")
  result.IGameServersService.methods.add("GetServerSteamIDsByIP:V1")
  result.IGameServersService.methods.add("GetServerIPsBySteamID:V1")
  result.IGameServersService.methods.add("QueryByFakeIP:V1")
  result.IPlayerService.name = "IPlayerService"
  result.IPlayerService.methods.add("IsPlayingSharedGame:V1")
  result.IPlayerService.methods.add("RecordOfflinePlaytime:V1")
  result.IPlayerService.methods.add("GetRecentlyPlayedGames:V1")
  result.IPlayerService.methods.add("GetOwnedGames:V1")
  result.IPlayerService.methods.add("GetSteamLevel:V1")
  result.IPlayerService.methods.add("GetBadges:V1")
  result.IPlayerService.methods.add("GetCommunityBadgeProgress:V1")
  result.IBroadcastService.name = "IBroadcastService"
  result.IBroadcastService.methods.add("PostGameDataFrameRTMP:V1")
  result.IContentServerConfigService.name = "IContentServerConfigService"
  result.IContentServerConfigService.methods.add("SetSteamCacheClientFilters:V1")
  result.IContentServerConfigService.methods.add("GetSteamCacheNodeParams:V1")
  result.IContentServerConfigService.methods.add("SetSteamCachePerformanceStats:V1")
  result.IContentServerDirectoryService.name = "IContentServerDirectoryService"
  result.IContentServerDirectoryService.methods.add("GetServersForSteamPipe:V1")
  result.IContentServerDirectoryService.methods.add("GetClientUpdateHosts:V1")
  result.IContentServerDirectoryService.methods.add("GetDepotPatchInfo:V1")
  result.IPublishedFileService.name = "IPublishedFileService"
  result.IPublishedFileService.methods.add("GetUserVoteSummary:V1")
  result.IPublishedFileService.methods.add("QueryFiles:V1")
  result.IPublishedFileService.methods.add("GetDetails:V1")
  result.IPublishedFileService.methods.add("GetUserFiles:V1")
  result.IEconService.name = "IEconService"
  result.IEconService.methods.add("GetTradeHistory:V1")
  result.IEconService.methods.add("GetTradeStatus:V1")
  result.IEconService.methods.add("GetTradeOffers:V1")
  result.IEconService.methods.add("GetTradeOffer:V1")
  result.IEconService.methods.add("GetTradeOffersSummary:V1")
  result.IEconService.methods.add("GetTradeHoldDurations:V1")
  result.IGameNotificationsService.name = "IGameNotificationsService"
  result.IGameNotificationsService.methods.add("UserCreateSession:V1")
  result.IGameNotificationsService.methods.add("UserUpdateSession:V1")
  result.IGameNotificationsService.methods.add("UserDeleteSession:V1")
  result.IInventoryService.name = "IInventoryService"
  result.IInventoryService.methods.add("SplitItemStack:V1")
  result.IInventoryService.methods.add("CombineItemStacks:V1")
  result.IInventoryService.methods.add("GetPriceSheet:V1")
  result.IStoreService.name = "IStoreService"
  result.IStoreService.methods.add("GetAppList:V1")
  result.ICheatReportingService.name = "ICheatReportingService"
  result.ICheatReportingService.methods.add("ReportCheatData:V1")
  return result


proc `ReportEventV1`*(interfacename: IClientStats_1046930): string = 
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ReportEvent/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetNextMatchSharingCodeV1`*(interfacename: ICSGOPlayers_730, `steamid`: uint64, `steamidkey`: string, `knowncode`: string): string = 
  ## `steamid` : uint64 — The SteamID of the user
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## `knowncode` : string — Previously known match sharing code obtained from the SteamID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNextMatchSharingCode/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGameMapsPlaytimeV1`*(interfacename: ICSGOServers_730, `interval`: string, `gamemode`: string, `mapgroup`: string): string = 
  ## `interval` : string — What recent interval is requested, possible values: day, week, month
  ## `gamemode` : string — What game mode is requested, possible values: competitive, casual
  ## `mapgroup` : string — What maps are requested, possible values: operation
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameMapsPlaytime/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGameServersStatusV1`*(interfacename: ICSGOServers_730): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameServersStatus/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentFantasyLineupV1`*(interfacename: ICSGOTournaments_730, `event`: uint32, `steamid`: uint64, `steamidkey`: string): string = 
  ## `event` : uint32 — The event ID
  ## `steamid` : uint64 — The SteamID of the user inventory
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentFantasyLineup/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentItemsV1`*(interfacename: ICSGOTournaments_730, `event`: uint32, `steamid`: uint64, `steamidkey`: string): string = 
  ## `event` : uint32 — The event ID
  ## `steamid` : uint64 — The SteamID of the user inventory
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentLayoutV1`*(interfacename: ICSGOTournaments_730, `event`: uint32): string = 
  ## `event` : uint32 — The event ID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentLayout/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPredictionsV1`*(interfacename: ICSGOTournaments_730, `event`: uint32, `steamid`: uint64, `steamidkey`: string): string = 
  ## `event` : uint32 — The event ID
  ## `steamid` : uint64 — The SteamID of the user inventory
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPredictions/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `UploadTournamentFantasyLineupV1`*(interfacename: ICSGOTournaments_730, `event`: uint32, `steamid`: uint64, `steamidkey`: string, `sectionid`: uint32, `pickid0`: uint32, `itemid0`: uint64, `pickid1`: uint32, `itemid1`: uint64, `pickid2`: uint32, `itemid2`: uint64, `pickid3`: uint32, `itemid3`: uint64, `pickid4`: uint32, `itemid4`: uint64): string = 
  ## `event` : uint32 — The event ID
  ## `steamid` : uint64 — The SteamID of the user inventory
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## `sectionid` : uint32 — Event section id
  ## `pickid0` : uint32 — PickID to select for the slot
  ## `itemid0` : uint64 — ItemID to lock in for the pick
  ## `pickid1` : uint32 — PickID to select for the slot
  ## `itemid1` : uint64 — ItemID to lock in for the pick
  ## `pickid2` : uint32 — PickID to select for the slot
  ## `itemid2` : uint64 — ItemID to lock in for the pick
  ## `pickid3` : uint32 — PickID to select for the slot
  ## `itemid3` : uint64 — ItemID to lock in for the pick
  ## `pickid4` : uint32 — PickID to select for the slot
  ## `itemid4` : uint64 — ItemID to lock in for the pick
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UploadTournamentFantasyLineup/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `UploadTournamentPredictionsV1`*(interfacename: ICSGOTournaments_730, `event`: uint32, `steamid`: uint64, `steamidkey`: string, `sectionid`: uint32, `groupid`: uint32, `index`: uint32, `pickid`: uint32, `itemid`: uint64): string = 
  ## `event` : uint32 — The event ID
  ## `steamid` : uint64 — The SteamID of the user inventory
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## `sectionid` : uint32 — Event section id
  ## `groupid` : uint32 — Event group id
  ## `index` : uint32 — Index in group
  ## `pickid` : uint32 — Pick ID to select
  ## `itemid` : uint64 — ItemID to lock in for the pick
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UploadTournamentPredictions/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetFantasyPlayerStatsV1`*(interfacename: IDOTA2Fantasy_205790, `FantasyLeagueID`: uint32, `StartTime`: uint32, `EndTime`: uint32, `MatchID`: uint64, `SeriesID`: uint32, `PlayerAccountID`: uint32): string = 
  ## `FantasyLeagueID` : uint32 — The fantasy league ID
  ## `StartTime` : uint32 — An optional filter for minimum timestamp
  ## `EndTime` : uint32 — An optional filter for maximum timestamp
  ## `MatchID` : uint64 — An optional filter for a specific match
  ## `SeriesID` : uint32 — An optional filter for a specific series
  ## `PlayerAccountID` : uint32 — An optional filter for a specific player
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetFantasyPlayerStats/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerOfficialInfoV1`*(interfacename: IDOTA2Fantasy_205790, `accountid`: uint32): string = 
  ## `accountid` : uint32 — The account ID to look up
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerOfficialInfo/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetProPlayerListV1`*(interfacename: IDOTA2Fantasy_205790): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetProPlayerList/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetRealtimeStatsV1`*(interfacename: IDOTA2MatchStats_205790, `server_steam_id`: uint64): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRealtimeStats/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetRealtimeStatsV1`*(interfacename: IDOTA2MatchStats_570, `server_steam_id`: uint64): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRealtimeStats/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetLeagueListingV1`*(interfacename: IDOTA2Match_205790): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLeagueListing/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetLiveLeagueGamesV1`*(interfacename: IDOTA2Match_205790, `league_id`: uint32, `match_id`: uint64): string = 
  ## `league_id` : uint32 — Only show matches of the specified league id
  ## `match_id` : uint64 — Only show matches of the specified match id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLiveLeagueGames/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchDetailsV1`*(interfacename: IDOTA2Match_205790, `match_id`: uint64): string = 
  ## `match_id` : uint64 — Match id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchDetails/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchHistoryV1`*(interfacename: IDOTA2Match_205790, `hero_id`: uint32, `game_mode`: uint32, `skill`: uint32, `min_players`: string, `account_id`: string, `league_id`: string, `start_at_match_id`: uint64, `matches_requested`: string): string = 
  ## `hero_id` : uint32 — The ID of the hero that must be in the matches being queried
  ## `game_mode` : uint32 — Which game mode to return matches for
  ## `skill` : uint32 — The average skill range of the match, these can be [1-3] with lower numbers being lower skill. Ignored if an account ID is specified
  ## `min_players` : string — Minimum number of human players that must be in a match for it to be returned
  ## `account_id` : string — An account ID to get matches from. This will fail if the user has their match history hidden
  ## `league_id` : string — The league ID to return games from
  ## `start_at_match_id` : uint64 — The minimum match ID to start from
  ## `matches_requested` : string — The number of requested matches to return
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistory/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchHistoryBySequenceNumV1`*(interfacename: IDOTA2Match_205790, `start_at_match_seq_num`: uint64, `matches_requested`: uint32): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistoryBySequenceNum/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTeamInfoByTeamIDV1`*(interfacename: IDOTA2Match_205790, `start_at_team_id`: uint64, `teams_requested`: uint32): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTeamInfoByTeamID/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopLiveEventGameV1`*(interfacename: IDOTA2Match_205790, `partner`: int32): string = 
  ## `partner` : int32 — Which partner's games to use.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveEventGame/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopLiveGameV1`*(interfacename: IDOTA2Match_205790, `partner`: int32): string = 
  ## `partner` : int32 — Which partner's games to use.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveGame/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopWeekendTourneyGamesV1`*(interfacename: IDOTA2Match_205790, `partner`: int32, `home_division`: int32): string = 
  ## `partner` : int32 — Which partner's games to use.
  ## `home_division` : int32 — Prefer matches from this division.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopWeekendTourneyGames/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPlayerStatsV1`*(interfacename: IDOTA2Match_205790, `account_id`: string, `league_id`: string, `hero_id`: string, `time_frame`: string, `match_id`: uint64, `phase_id`: uint32): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPlayerStatsV2`*(interfacename: IDOTA2Match_205790, `account_id`: string, `league_id`: string, `hero_id`: string, `time_frame`: string, `match_id`: uint64, `phase_id`: uint32): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetLiveLeagueGamesV1`*(interfacename: IDOTA2Match_570, `league_id`: uint32, `match_id`: uint64, `dpc`: bool): string = 
  ## `league_id` : uint32 — Only show matches of the specified league id
  ## `match_id` : uint64 — Only show matches of the specified match id
  ## `dpc` : bool — Only show matches that are part of the DPC
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLiveLeagueGames/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchDetailsV1`*(interfacename: IDOTA2Match_570, `match_id`: uint64, `include_persona_names`: bool): string = 
  ## `match_id` : uint64 — Match id
  ## `include_persona_names` : bool — Include persona names as part of the response
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchDetails/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchHistoryV1`*(interfacename: IDOTA2Match_570, `hero_id`: uint32, `game_mode`: uint32, `skill`: uint32, `min_players`: string, `account_id`: string, `league_id`: string, `start_at_match_id`: uint64, `matches_requested`: string): string = 
  ## `hero_id` : uint32 — The ID of the hero that must be in the matches being queried
  ## `game_mode` : uint32 — Which game mode to return matches for
  ## `skill` : uint32 — The average skill range of the match, these can be [1-3] with lower numbers being lower skill. Ignored if an account ID is specified
  ## `min_players` : string — Minimum number of human players that must be in a match for it to be returned
  ## `account_id` : string — An account ID to get matches from. This will fail if the user has their match history hidden
  ## `league_id` : string — The league ID to return games from
  ## `start_at_match_id` : uint64 — The minimum match ID to start from
  ## `matches_requested` : string — The number of requested matches to return
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistory/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetMatchHistoryBySequenceNumV1`*(interfacename: IDOTA2Match_570, `start_at_match_seq_num`: uint64, `matches_requested`: uint32): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistoryBySequenceNum/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTeamInfoByTeamIDV1`*(interfacename: IDOTA2Match_570, `start_at_team_id`: uint64, `teams_requested`: uint32): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTeamInfoByTeamID/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopLiveEventGameV1`*(interfacename: IDOTA2Match_570, `partner`: int32): string = 
  ## `partner` : int32 — Which partner's games to use.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveEventGame/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopLiveGameV1`*(interfacename: IDOTA2Match_570, `partner`: int32): string = 
  ## `partner` : int32 — Which partner's games to use.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveGame/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTopWeekendTourneyGamesV1`*(interfacename: IDOTA2Match_570, `partner`: int32, `home_division`: int32): string = 
  ## `partner` : int32 — Which partner's games to use.
  ## `home_division` : int32 — Prefer matches from this division.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopWeekendTourneyGames/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPlayerStatsV1`*(interfacename: IDOTA2Match_570, `account_id`: string, `league_id`: string, `hero_id`: string, `time_frame`: string, `match_id`: uint64): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPlayerStatsV2`*(interfacename: IDOTA2Match_570, `account_id`: string, `league_id`: string, `hero_id`: string, `time_frame`: string, `match_id`: uint64, `phase_id`: uint32): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetBroadcasterInfoV1`*(interfacename: IDOTA2StreamSystem_205790, `broadcaster_steam_id`: uint64, `league_id`: uint32): string = 
  ## `broadcaster_steam_id` : uint64 — 64-bit Steam ID of the broadcaster
  ## `league_id` : uint32 — LeagueID to use if we aren't in a lobby
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBroadcasterInfo/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetBroadcasterInfoV1`*(interfacename: IDOTA2StreamSystem_570, `broadcaster_steam_id`: uint64, `league_id`: uint32): string = 
  ## `broadcaster_steam_id` : uint64 — 64-bit Steam ID of the broadcaster
  ## `league_id` : uint32 — LeagueID to use if we aren't in a lobby
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBroadcasterInfo/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `ClaimBadgeRewardV1`*(interfacename: IDOTA2Ticket_205790, `BadgeID`: string, `ValidBadgeType1`: uint32, `ValidBadgeType2`: uint32, `ValidBadgeType3`: uint32): string = 
  ## `BadgeID` : string — The Badge ID
  ## `ValidBadgeType1` : uint32 — Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — Valid Badge Type 3
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ClaimBadgeReward/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSteamIDForBadgeIDV1`*(interfacename: IDOTA2Ticket_205790, `BadgeID`: string): string = 
  ## `BadgeID` : string — The badge ID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamIDForBadgeID/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `SetSteamAccountPurchasedV1`*(interfacename: IDOTA2Ticket_205790, `steamid`: uint64, `BadgeType`: uint32): string = 
  ## `steamid` : uint64 — The 64-bit Steam ID
  ## `BadgeType` : uint32 — Badge Type
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamAccountPurchased/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `SteamAccountValidForBadgeTypeV1`*(interfacename: IDOTA2Ticket_205790, `steamid`: uint64, `ValidBadgeType1`: uint32, `ValidBadgeType2`: uint32, `ValidBadgeType3`: uint32): string = 
  ## `steamid` : uint64 — The 64-bit Steam ID
  ## `ValidBadgeType1` : uint32 — Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — Valid Badge Type 3
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/SteamAccountValidForBadgeType/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `SetSteamAccountPurchasedV1`*(interfacename: IDOTA2Ticket_570, `SteamID`: uint64, `BadgeType`: uint32): string = 
  ## `SteamID` : uint64 — The 64-bit Steam ID
  ## `BadgeType` : uint32 — Badge Type
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamAccountPurchased/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `SteamAccountValidForBadgeTypeV1`*(interfacename: IDOTA2Ticket_570, `SteamID`: uint64, `ValidBadgeType1`: uint32, `ValidBadgeType2`: uint32, `ValidBadgeType3`: uint32): string = 
  ## `SteamID` : uint64 — The 64-bit Steam ID
  ## `ValidBadgeType1` : uint32 — Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — Valid Badge Type 3
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/SteamAccountValidForBadgeType/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEventStatsForAccountV1`*(interfacename: IEconDOTA2_205790, `eventid`: uint32, `accountid`: uint32, `language`: string): string = 
  ## `eventid` : uint32 — The League ID of the compendium you're looking for.
  ## `accountid` : uint32 — The account ID to look up.
  ## `language` : string — The language to provide hero names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEventStatsForAccount/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGameItemsV1`*(interfacename: IEconDOTA2_205790, `language`: string): string = 
  ## `language` : string — The language to provide item names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetHeroesV1`*(interfacename: IEconDOTA2_205790, `language`: string, `itemizedonly`: bool): string = 
  ## `language` : string — The language to provide hero names in.
  ## `itemizedonly` : bool — Return a list of itemized heroes only.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetHeroes/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetItemIconPathV1`*(interfacename: IEconDOTA2_205790, `iconname`: string, `icontype`: uint32): string = 
  ## `iconname` : string — The item icon name to get the CDN path of
  ## `icontype` : uint32 — The type of image you want. 0 = normal, 1 = large, 2 = ingame
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemIconPath/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetRaritiesV1`*(interfacename: IEconDOTA2_205790, `language`: string): string = 
  ## `language` : string — The language to provide rarity names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRarities/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPrizePoolV1`*(interfacename: IEconDOTA2_205790, `leagueid`: uint32): string = 
  ## `leagueid` : uint32 — The ID of the league to get the prize pool of
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPrizePool/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEventStatsForAccountV1`*(interfacename: IEconDOTA2_570, `eventid`: uint32, `accountid`: uint32, `language`: string): string = 
  ## `eventid` : uint32 — The Event ID of the event you're looking for.
  ## `accountid` : uint32 — The account ID to look up.
  ## `language` : string — The language to provide hero names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEventStatsForAccount/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGameItemsV1`*(interfacename: IEconDOTA2_570, `language`: string): string = 
  ## `language` : string — The language to provide item names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetHeroesV1`*(interfacename: IEconDOTA2_570, `language`: string, `itemizedonly`: bool): string = 
  ## `language` : string — The language to provide hero names in.
  ## `itemizedonly` : bool — Return a list of itemized heroes only.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetHeroes/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetItemCreatorsV1`*(interfacename: IEconDOTA2_570, `itemdef`: uint32): string = 
  ## `itemdef` : uint32 — The item definition to get creator information for.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemCreators/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetItemWorkshopPublishedFileIDsV1`*(interfacename: IEconDOTA2_570, `itemdef`: uint32): string = 
  ## `itemdef` : uint32 — The item definition to get published file ids for.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemWorkshopPublishedFileIDs/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetRaritiesV1`*(interfacename: IEconDOTA2_570, `language`: string): string = 
  ## `language` : string — The language to provide rarity names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRarities/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTournamentPrizePoolV1`*(interfacename: IEconDOTA2_570, `leagueid`: uint32): string = 
  ## `leagueid` : uint32 — The ID of the league to get the prize pool of
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPrizePool/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_1046930, `steamid`: uint64): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: IEconItems_1269260, `steamid`: uint64, `class_id`: uint32): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `class_id` : uint32 — Return items equipped for this class id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: IEconItems_205790, `steamid`: uint64, `class_id`: uint32): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `class_id` : uint32 — Return items equipped for this class id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_205790, `steamid`: uint64): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaURLV1`*(interfacename: IEconItems_205790): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: IEconItems_205790, `language`: string): string = 
  ## `language` : string — The language to results in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_221540, `steamid`: uint64): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_238460, `steamid`: uint64): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_440, `steamid`: uint64): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaV1`*(interfacename: IEconItems_440, `language`: string): string = 
  ## `language` : string — The language to return the names in. Defaults to returning string keys.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaItemsV1`*(interfacename: IEconItems_440, `language`: string, `start`: int32): string = 
  ## `language` : string — The language to return the names in. Defaults to returning string keys.
  ## `start` : int32 — The first item id to return. Defaults to 0. Response will indicate next value to query if applicable.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaOverviewV1`*(interfacename: IEconItems_440, `language`: string): string = 
  ## `language` : string — The language to return the names in. Defaults to returning string keys.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaOverview/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaURLV1`*(interfacename: IEconItems_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: IEconItems_440, `language`: string): string = 
  ## `language` : string — The language to results in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetStoreStatusV1`*(interfacename: IEconItems_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreStatus/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: IEconItems_570, `SteamID`: uint64, `class_id`: uint32): string = 
  ## `SteamID` : uint64 — The Steam ID to fetch items for
  ## `class_id` : uint32 — Return items equipped for this class id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_570, `SteamID`: uint64): string = 
  ## `SteamID` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: IEconItems_570, `language`: string): string = 
  ## `language` : string — The language to results in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: IEconItems_583950, `steamid`: uint64, `class_id`: uint32): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `class_id` : uint32 — Return items equipped for this class id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_620, `steamid`: uint64): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaV1`*(interfacename: IEconItems_620, `language`: string): string = 
  ## `language` : string — The language to return the names in. Defaults to returning string keys.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: IEconItems_730, `steamid`: uint64): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaV2`*(interfacename: IEconItems_730, `language`: string): string = 
  ## `language` : string — The language to return the names in. Defaults to returning string keys.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaURLV2`*(interfacename: IEconItems_730): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: IEconItems_730, `language`: string): string = 
  ## `language` : string — The language to results in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_1046930): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_1046930): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_1269260): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_1269260): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_205790): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_205790): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_570): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_570): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: IGCVersion_583950): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_583950): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: IGCVersion_730): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetBucketizedDataV1`*(interfacename: IPortal2Leaderboards_620, `leaderboardName`: string): string = 
  ## `leaderboardName` : string — The leaderboard name to fetch data for.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBucketizedData/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAppListV1`*(interfacename: ISteamApps): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAppListV2`*(interfacename: ISteamApps): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSDRConfigV1`*(interfacename: ISteamApps, `appid`: uint32): string = 
  ## `appid` : uint32 — AppID of game
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSDRConfig/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServersAtAddressV1`*(interfacename: ISteamApps, `addr`: string): string = 
  ## `addr` : string — IP or IP:queryport to list
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServersAtAddress/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `UpToDateCheckV1`*(interfacename: ISteamApps, `appid`: uint32, `version`: uint32): string = 
  ## `appid` : uint32 — AppID of game
  ## `version` : uint32 — The installed version of the game
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/UpToDateCheck/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `ViewerHeartbeatV1`*(interfacename: ISteamBroadcast, `steamid`: uint64, `sessionid`: uint64, `token`: uint64, `stream`: int32): string = 
  ## `steamid` : uint64 — Steam ID of the broadcaster
  ## `sessionid` : uint64 — Broadcast Session ID
  ## `token` : uint64 — Viewer token
  ## `stream` : int32 — video stream representation watching
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ViewerHeartbeat/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `SetClientFiltersV1`*(interfacename: ISteamCDN, `key`: string, `cdnname`: string, `allowedipblocks`: string, `allowedasns`: string, `allowedipcountries`: string): string = 
  ## `key` : string — access key
  ## `cdnname` : string — Steam name of CDN property
  ## `allowedipblocks` : string — comma-separated list of allowed IP address blocks in CIDR format - blank for not used
  ## `allowedasns` : string — comma-separated list of allowed client network AS numbers - blank for not used
  ## `allowedipcountries` : string — comma-separated list of allowed client IP country codes in ISO 3166-1 format - blank for not used
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetClientFilters/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `SetPerformanceStatsV1`*(interfacename: ISteamCDN, `key`: string, `cdnname`: string, `mbps_sent`: uint32, `mbps_recv`: uint32, `cpu_percent`: uint32, `cache_hit_percent`: uint32): string = 
  ## `key` : string — access key
  ## `cdnname` : string — Steam name of CDN property
  ## `mbps_sent` : uint32 — Outgoing network traffic in Mbps
  ## `mbps_recv` : uint32 — Incoming network traffic in Mbps
  ## `cpu_percent` : uint32 — Percent CPU load
  ## `cache_hit_percent` : uint32 — Percent cache hits
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetPerformanceStats/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetCMListV1`*(interfacename: ISteamDirectory, `cellid`: uint32, `maxcount`: uint32): string = 
  ## `cellid` : uint32 — Client's Steam cell ID
  ## `maxcount` : uint32 — Max number of servers to return
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCMList/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetCMListForConnectV1`*(interfacename: ISteamDirectory, `cellid`: uint32, `cmtype`: string, `realm`: string, `maxcount`: uint32): string = 
  ## `cellid` : uint32 — Client's Steam cell ID, uses IP location if blank
  ## `cmtype` : string — Optional CM type filter
  ## `realm` : string — Optional Steam Realm filter
  ## `maxcount` : uint32 — Max number of servers to return
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCMListForConnect/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSteamPipeDomainsV1`*(interfacename: ISteamDirectory): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamPipeDomains/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAssetClassInfoV1`*(interfacename: ISteamEconomy, `appid`: uint32, `language`: string, `class_count`: uint32, `classid0`: uint64, `instanceid0`: uint64): string = 
  ## `appid` : uint32 — Must be a steam economy app.
  ## `language` : string — The user's local language
  ## `class_count` : uint32 — Number of classes requested. Must be at least one.
  ## `classid0` : uint64 — Class ID of the nth class.
  ## `instanceid0` : uint64 — Instance ID of the nth class.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAssetClassInfo/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAssetPricesV1`*(interfacename: ISteamEconomy, `appid`: uint32, `currency`: string, `language`: string): string = 
  ## `appid` : uint32 — Must be a steam economy app.
  ## `currency` : string — The currency to filter for
  ## `language` : string — The user's local language
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAssetPrices/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetNewsForAppV1`*(interfacename: ISteamNews, `appid`: uint32, `maxlength`: uint32, `enddate`: uint32, `count`: uint32, `tags`: string): string = 
  ## `appid` : uint32 — AppID to retrieve news for
  ## `maxlength` : uint32 — Maximum length for the content to return, if this is 0 the full content is returned, if it's less then a blurb is generated to fit.
  ## `enddate` : uint32 — Retrieve posts earlier than this date (unix epoch timestamp)
  ## `count` : uint32 — # of posts to retrieve (default 20)
  ## `tags` : string — Comma-separated list of tags to filter by (e.g. 'patchnodes')
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNewsForApp/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetNewsForAppV2`*(interfacename: ISteamNews, `appid`: uint32, `maxlength`: uint32, `enddate`: uint32, `count`: uint32, `feeds`: string, `tags`: string): string = 
  ## `appid` : uint32 — AppID to retrieve news for
  ## `maxlength` : uint32 — Maximum length for the content to return, if this is 0 the full content is returned, if it's less then a blurb is generated to fit.
  ## `enddate` : uint32 — Retrieve posts earlier than this date (unix epoch timestamp)
  ## `count` : uint32 — # of posts to retrieve (default 20)
  ## `feeds` : string — Comma-separated list of feed names to return news for
  ## `tags` : string — Comma-separated list of tags to filter by (e.g. 'patchnodes')
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNewsForApp/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetCollectionDetailsV1`*(interfacename: ISteamRemoteStorage, `collectioncount`: uint32, `publishedfileids`: seq[uint64]): string = 
  ## `collectioncount` : uint32 — Number of collections being requested
  ## `publishedfileids[0]` : uint64 — collection ids to get the details for
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCollectionDetails/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetPublishedFileDetailsV1`*(interfacename: ISteamRemoteStorage, `itemcount`: uint32, `publishedfileids`: seq[uint64]): string = 
  ## `itemcount` : uint32 — Number of items being requested
  ## `publishedfileids[0]` : uint64 — published file id to look up
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPublishedFileDetails/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetUGCFileDetailsV1`*(interfacename: ISteamRemoteStorage, `steamid`: uint64, `ugcid`: uint64, `appid`: uint32): string = 
  ## `steamid` : uint64 — If specified, only returns details if the file is owned by the SteamID specified
  ## `ugcid` : uint64 — ID of UGC file to get info for
  ## `appid` : uint32 — appID of product
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUGCFileDetails/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetFriendListV1`*(interfacename: ISteamUser, `key`: string, `steamid`: uint64, `relationship`: string): string = 
  ## `key` : string — access key
  ## `steamid` : uint64 — SteamID of user
  ## `relationship` : string — relationship type (ex: friend)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetFriendList/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerBansV1`*(interfacename: ISteamUser, `key`: string, `steamids`: string): string = 
  ## `key` : string — access key
  ## `steamids` : string — Comma-delimited list of SteamIDs
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerBans/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerSummariesV1`*(interfacename: ISteamUser, `key`: string, `steamids`: string): string = 
  ## `key` : string — access key
  ## `steamids` : string — Comma-delimited list of SteamIDs
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerSummaries/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerSummariesV2`*(interfacename: ISteamUser, `key`: string, `steamids`: string): string = 
  ## `key` : string — access key
  ## `steamids` : string — Comma-delimited list of SteamIDs (max: 100)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerSummaries/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetUserGroupListV1`*(interfacename: ISteamUser, `key`: string, `steamid`: uint64): string = 
  ## `key` : string — access key
  ## `steamid` : uint64 — SteamID of user
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserGroupList/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `ResolveVanityURLV1`*(interfacename: ISteamUser, `key`: string, `vanityurl`: string, `url_type`: int32): string = 
  ## `key` : string — access key
  ## `vanityurl` : string — The vanity URL to get a SteamID for
  ## `url_type` : int32 — The type of vanity URL. 1 (default): Individual profile, 2: Group, 3: Official game group
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ResolveVanityURL/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `AuthenticateUserV1`*(interfacename: ISteamUserAuth, `steamid`: uint64, `sessionkey`: Rawbinary, `encrypted_loginkey`: Rawbinary): string = 
  ## `steamid` : uint64 — Should be the users steamid, unencrypted.
  ## `sessionkey` : Rawbinary — Should be a 32 byte random blob of data, which is then encrypted with RSA using the Steam system's public key.  Randomness is important here for security.
  ## `encrypted_loginkey` : Rawbinary — Should be the users hashed loginkey, AES encrypted with the sessionkey.
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/AuthenticateUser/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `AuthenticateUserTicketV1`*(interfacename: ISteamUserAuth, `key`: string, `appid`: uint32, `ticket`: string): string = 
  ## `key` : string — access key
  ## `appid` : uint32 — appid of game
  ## `ticket` : string — Ticket from GetAuthSessionTicket.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/AuthenticateUserTicket/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTokenDetailsV1`*(interfacename: ISteamUserOAuth, `access_token`: string): string = 
  ## `access_token` : string — OAuth2 token for which to return details
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTokenDetails/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGlobalAchievementPercentagesForAppV1`*(interfacename: ISteamUserStats, `gameid`: uint64): string = 
  ## `gameid` : uint64 — GameID to retrieve the achievement percentages for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalAchievementPercentagesForApp/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGlobalAchievementPercentagesForAppV2`*(interfacename: ISteamUserStats, `gameid`: uint64): string = 
  ## `gameid` : uint64 — GameID to retrieve the achievement percentages for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalAchievementPercentagesForApp/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGlobalStatsForGameV1`*(interfacename: ISteamUserStats, `appid`: uint32, `count`: uint32, `name`: seq[string], `startdate`: uint32, `enddate`: uint32): string = 
  ## `appid` : uint32 — AppID that we're getting global stats for
  ## `count` : uint32 — Number of stats get data for
  ## `name[0]` : string — Names of stat to get data for
  ## `startdate` : uint32 — Start date for daily totals (unix epoch timestamp)
  ## `enddate` : uint32 — End date for daily totals (unix epoch timestamp)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalStatsForGame/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetNumberOfCurrentPlayersV1`*(interfacename: ISteamUserStats, `appid`: uint32): string = 
  ## `appid` : uint32 — AppID that we're getting user count for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNumberOfCurrentPlayers/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetPlayerAchievementsV1`*(interfacename: ISteamUserStats, `key`: string, `steamid`: uint64, `appid`: uint32, `l`: string): string = 
  ## `key` : string — access key
  ## `steamid` : uint64 — SteamID of user
  ## `appid` : uint32 — AppID to get achievements for
  ## `l` : string — Language to return strings for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerAchievements/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaForGameV1`*(interfacename: ISteamUserStats, `key`: string, `appid`: uint32, `l`: string): string = 
  ## `key` : string — access key
  ## `appid` : uint32 — appid of game
  ## `l` : string — localized langauge to return (english, french, etc.)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaForGame/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSchemaForGameV2`*(interfacename: ISteamUserStats, `key`: string, `appid`: uint32, `l`: string): string = 
  ## `key` : string — access key
  ## `appid` : uint32 — appid of game
  ## `l` : string — localized language to return (english, french, etc.)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaForGame/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetUserStatsForGameV1`*(interfacename: ISteamUserStats, `key`: string, `steamid`: uint64, `appid`: uint32): string = 
  ## `key` : string — access key
  ## `steamid` : uint64 — SteamID of user
  ## `appid` : uint32 — appid of game
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserStatsForGame/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetUserStatsForGameV2`*(interfacename: ISteamUserStats, `key`: string, `steamid`: uint64, `appid`: uint32): string = 
  ## `key` : string — access key
  ## `steamid` : uint64 — SteamID of user
  ## `appid` : uint32 — appid of game
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserStatsForGame/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerInfoV1`*(interfacename: ISteamWebAPIUtil): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerInfo/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSupportedAPIListV1`*(interfacename: ISteamWebAPIUtil, `key`: string): string = 
  ## `key` : string — access key
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSupportedAPIList/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `PollStatusV1`*(interfacename: ISteamWebUserPresenceOAuth, `steamid`: string, `umqid`: uint64, `message`: uint32, `pollid`: uint32, `sectimeout`: uint32, `secidletime`: uint32, `use_accountids`: uint32): string = 
  ## `steamid` : string — Steam ID of the user
  ## `umqid` : uint64 — UMQ Session ID
  ## `message` : uint32 — Message that was last known to the user
  ## `pollid` : uint32 — Caller-specific poll id
  ## `sectimeout` : uint32 — Long-poll timeout in seconds
  ## `secidletime` : uint32 — How many seconds is client considering itself idle, e.g. screen is off
  ## `use_accountids` : uint32 — Boolean, 0 (default): return steamid_from in output, 1: return accountid_from
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/PollStatus/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetGoldenWrenchesV1`*(interfacename: ITFItems_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGoldenWrenches/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetGoldenWrenchesV2`*(interfacename: ITFItems_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGoldenWrenches/v2/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetItemIDV1`*(interfacename: ITFPromos_205790, `steamid`: uint64, `promoid`: uint32): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `promoid` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GrantItemV1`*(interfacename: ITFPromos_205790, `steamid`: uint64, `promoid`: uint32): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `promoid` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetItemIDV1`*(interfacename: ITFPromos_440, `steamid`: uint64, `promoid`: uint32): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `promoid` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GrantItemV1`*(interfacename: ITFPromos_440, `steamid`: uint64, `promoid`: uint32): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `promoid` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetItemIDV1`*(interfacename: ITFPromos_620, `steamid`: uint64, `PromoID`: uint32): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `PromoID` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GrantItemV1`*(interfacename: ITFPromos_620, `steamid`: uint64, `PromoID`: uint32): string = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `PromoID` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetWorldStatusV1`*(interfacename: ITFSystem_440): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetWorldStatus/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAccountListV1`*(interfacename: IGameServersService, `key`: string): string = 
  ## Gets a list of game server accounts with their logon tokens
  ## `key` : string — Access key
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAccountList/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `CreateAccountV1`*(interfacename: IGameServersService, `key`: string, `appid`: uint32, `memo`: string): string = 
  ## Creates a persistent game server account
  ## `key` : string — Access key
  ## `appid` : uint32 — The app to use the account for
  ## `memo` : string — The memo to set on the new account
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/CreateAccount/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `SetMemoV1`*(interfacename: IGameServersService, `key`: string, `steamid`: uint64, `memo`: string): string = 
  ## This method changes the memo associated with the game server account. Memos do not affect the account in any way. The memo shows up in the GetAccountList response and serves only as a reminder of what the account is used for.
  ## `key` : string — Access key
  ## `steamid` : uint64 — The SteamID of the game server to set the memo on
  ## `memo` : string — The memo to set on the new account
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetMemo/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `ResetLoginTokenV1`*(interfacename: IGameServersService, `key`: string, `steamid`: uint64): string = 
  ## Generates a new login token for the specified game server
  ## `key` : string — Access key
  ## `steamid` : uint64 — The SteamID of the game server to reset the login token of
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ResetLoginToken/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `DeleteAccountV1`*(interfacename: IGameServersService, `key`: string, `steamid`: uint64): string = 
  ## Deletes a persistent game server account
  ## `key` : string — Access key
  ## `steamid` : uint64 — The SteamID of the game server account to delete
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/DeleteAccount/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetAccountPublicInfoV1`*(interfacename: IGameServersService, `key`: string, `steamid`: uint64): string = 
  ## Gets public information about a given game server account
  ## `key` : string — Access key
  ## `steamid` : uint64 — The SteamID of the game server to get info on
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAccountPublicInfo/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `QueryLoginTokenV1`*(interfacename: IGameServersService, `key`: string, `login_token`: string): string = 
  ## Queries the status of the specified token, which must be owned by you
  ## `key` : string — Access key
  ## `login_token` : string — Login token to query
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryLoginToken/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerSteamIDsByIPV1`*(interfacename: IGameServersService, `key`: string, `server_ips`: string): string = 
  ## Gets a list of server SteamIDs given a list of IPs
  ## `key` : string — Access key
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerSteamIDsByIP/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetServerIPsBySteamIDV1`*(interfacename: IGameServersService, `key`: string, `server_steamids`: uint64): string = 
  ## Gets a list of server IP addresses given a list of SteamIDs
  ## `key` : string — Access key
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerIPsBySteamID/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `QueryByFakeIPV1`*(interfacename: IGameServersService, `key`: string, `fake_ip`: uint32, `fake_port`: uint32, `app_id`: uint32, `query_type`: int): string = 
  ## Perform a query on a specific server by FakeIP
  ## `key` : string — Access key
  ## `fake_ip` : uint32 — FakeIP of server to query.
  ## `fake_port` : uint32 — Fake port of server to query.
  ## `app_id` : uint32 — AppID to use.  Each AppID has its own FakeIP address.
  ## `query_type` : int — What type of query?
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryByFakeIP/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `IsPlayingSharedGameV1`*(interfacename: IPlayerService, `key`: string, `steamid`: uint64, `appid_playing`: uint32): string = 
  ## Obsolete, partners should use ISteamUser.CheckAppOwnership
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## `appid_playing` : uint32 — The game player is currently playing
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/IsPlayingSharedGame/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `RecordOfflinePlaytimeV1`*(interfacename: IPlayerService, `steamid`: uint64, `ticket`: string, `play_sessions`: Message): string = 
  ## Tracks playtime for a user when they are offline
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/RecordOfflinePlaytime/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetRecentlyPlayedGamesV1`*(interfacename: IPlayerService, `key`: string, `steamid`: uint64, `count`: uint32): string = 
  ## Gets information about a player's recently played games
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## `count` : uint32 — The number of games to return (0/unset: all)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRecentlyPlayedGames/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetOwnedGamesV1`*(interfacename: IPlayerService, `key`: string, `steamid`: uint64, `include_appinfo`: bool, `include_played_free_games`: bool, `appids_filter`: uint32, `include_free_sub`: bool, `skip_unvetted_apps`: bool): string = 
  ## Return a list of games owned by the player
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## `include_appinfo` : bool — true if we want additional details (name, icon) about each game
  ## `include_played_free_games` : bool — Free games are excluded by default.  If this is set, free games the user has played will be returned.
  ## `appids_filter` : uint32 — if set, restricts result set to the passed in apps
  ## `include_free_sub` : bool — Some games are in the free sub, which are excluded by default.
  ## `skip_unvetted_apps` : bool — if set, skip unvetted store apps
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetOwnedGames/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetSteamLevelV1`*(interfacename: IPlayerService, `key`: string, `steamid`: uint64): string = 
  ## Returns the Steam Level of a user
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamLevel/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetBadgesV1`*(interfacename: IPlayerService, `key`: string, `steamid`: uint64): string = 
  ## Gets badges that are owned by a specific user
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBadges/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetCommunityBadgeProgressV1`*(interfacename: IPlayerService, `key`: string, `steamid`: uint64, `badgeid`: int32): string = 
  ## Gets all the quests needed to get the specified badge, and which are completed
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## `badgeid` : int32 — The badge we're asking about
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCommunityBadgeProgress/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `PostGameDataFrameRTMPV1`*(interfacename: IBroadcastService, `appid`: uint32, `steamid`: uint64, `rtmp_token`: string, `frame_data`: string): string = 
  ## Add a game meta data frame to broadcast from a client. Uses RTMP token for validation
  ## `appid` : uint32 — AppID of the game being broadcasted
  ## `steamid` : uint64 — Broadcasters SteamID
  ## `rtmp_token` : string — Valid RTMP token for the Broadcaster
  ## `frame_data` : string — game data frame expressing current state of game (string, zipped, whatever)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/PostGameDataFrameRTMP/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `SetSteamCacheClientFiltersV1`*(interfacename: IContentServerConfigService, `key`: string, `cache_id`: uint32, `cache_key`: string, `change_notes`: string, `allowed_ip_blocks`: string): string = 
  ## Update the client filters for a SteamCache node
  ## `key` : string — Access key
  ## `cache_id` : uint32 — Unique ID number
  ## `cache_key` : string — Valid current cache API key
  ## `change_notes` : string — Notes
  ## `allowed_ip_blocks` : string — comma-separated list of allowed IP address blocks in CIDR format - blank to clear unfilter
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamCacheClientFilters/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetSteamCacheNodeParamsV1`*(interfacename: IContentServerConfigService, `key`: string, `cache_id`: uint32, `cache_key`: string): string = 
  ## Get the operational parameters for a SteamCache node (information the node uses to operate).
  ## `key` : string — Access key
  ## `cache_id` : uint32 — Unique ID number
  ## `cache_key` : string — Valid current cache API key
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamCacheNodeParams/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `SetSteamCachePerformanceStatsV1`*(interfacename: IContentServerConfigService, `key`: string, `cache_id`: uint32, `cache_key`: string, `mbps_sent`: uint32, `mbps_recv`: uint32, `cpu_percent`: uint32, `cache_hit_percent`: uint32, `num_connected_ips`: uint32, `upstream_egress_utilization`: uint32): string = 
  ## Update the performance/load stats for a SteamCache node
  ## `key` : string — Access key
  ## `cache_id` : uint32 — Unique ID number
  ## `cache_key` : string — Valid current cache API key
  ## `mbps_sent` : uint32 — Outgoing network traffic in Mbps
  ## `mbps_recv` : uint32 — Incoming network traffic in Mbps
  ## `cpu_percent` : uint32 — Percent CPU load
  ## `cache_hit_percent` : uint32 — Percent cache hits
  ## `num_connected_ips` : uint32 — Number of unique connected IP addresses
  ## `upstream_egress_utilization` : uint32 — What is the percent utilization of the busiest datacenter egress link?
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamCachePerformanceStats/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetServersForSteamPipeV1`*(interfacename: IContentServerDirectoryService, `cell_id`: uint32, `max_servers`: uint32, `ip_override`: string, `launcher_type`: int32, `ipv6_public`: string): string = 
  ## `cell_id` : uint32 — client Cell ID
  ## `max_servers` : uint32 — max servers in response list
  ## `ip_override` : string — client IP address
  ## `launcher_type` : int32 — launcher type
  ## `ipv6_public` : string — client public ipv6 address if it knows it
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServersForSteamPipe/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetClientUpdateHostsV1`*(interfacename: IContentServerDirectoryService, `cached_signature`: string): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientUpdateHosts/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetDepotPatchInfoV1`*(interfacename: IContentServerDirectoryService, `appid`: uint32, `depotid`: uint32, `source_manifestid`: uint64, `target_manifestid`: uint64): string = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetDepotPatchInfo/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetUserVoteSummaryV1`*(interfacename: IPublishedFileService, `publishedfileids`: uint64): string = 
  ## Get user vote summary
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserVoteSummary/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `QueryFilesV1`*(interfacename: IPublishedFileService, `key`: string, `query_type`: uint32, `page`: uint32, `cursor`: string, `numperpage`: uint32, `creator_appid`: uint32, `appid`: uint32, `requiredtags`: string, `excludedtags`: string, `match_all_tags`: bool, `required_flags`: string, `omitted_flags`: string, `search_text`: string, `filetype`: uint32, `child_publishedfileid`: uint64, `days`: uint32, `include_recent_votes_only`: bool, `cache_max_age_seconds`: uint32, `language`: int32, `required_kv_tags`: Message, `taggroups`: Message, `date_range_created`: Message, `date_range_updated`: Message, `totalonly`: bool, `ids_only`: bool, `return_vote_data`: bool, `return_tags`: bool, `return_kv_tags`: bool, `return_previews`: bool, `return_children`: bool, `return_short_description`: bool, `return_for_sale_data`: bool, `return_metadata`: bool, `return_playtime_stats`: uint32, `return_details`: bool, `strip_description_bbcode`: bool, `desired_revision`: int, `return_reactions`: bool): string = 
  ## Performs a search query for published files
  ## `key` : string — Access key
  ## `query_type` : uint32 — enumeration EPublishedFileQueryType in clientenums.h
  ## `page` : uint32 — Current page
  ## `cursor` : string — Cursor to paginate through the results (set to '*' for the first request).  Prefer this over using the page parameter, as it will allow you to do deep pagination.  When used, the page parameter will be ignored.
  ## `numperpage` : uint32 — (Optional) The number of results, per page to return.
  ## `creator_appid` : uint32 — App that created the files
  ## `appid` : uint32 — App that consumes the files
  ## `requiredtags` : string — Tags to match on. See match_all_tags parameter below
  ## `excludedtags` : string — (Optional) Tags that must NOT be present on a published file to satisfy the query.
  ## `match_all_tags` : bool — If true, then items must have all the tags specified, otherwise they must have at least one of the tags.
  ## `required_flags` : string — Required flags that must be set on any returned items
  ## `omitted_flags` : string — Flags that must not be set on any returned items
  ## `search_text` : string — Text to match in the item's title or description
  ## `filetype` : uint32 — EPublishedFileInfoMatchingFileType
  ## `child_publishedfileid` : uint64 — Find all items that reference the given item.
  ## `days` : uint32 — If query_type is k_PublishedFileQueryType_RankedByTrend, then this is the number of days to get votes for [1,7].
  ## `include_recent_votes_only` : bool — If query_type is k_PublishedFileQueryType_RankedByTrend, then limit result set just to items that have votes within the day range given
  ## `cache_max_age_seconds` : uint32 — Allow stale data to be returned for the specified number of seconds.
  ## `language` : int32 — Language to search in and also what gets returned. Defaults to English.
  ## `required_kv_tags` : Message — Required key-value tags to match on.
  ## `taggroups` : Message — (Optional) At least one of the tags must be present on a published file to satisfy the query.
  ## `date_range_created` : Message — (Optional) Filter to items created within this range.
  ## `date_range_updated` : Message — (Optional) Filter to items updated within this range.
  ## `totalonly` : bool — (Optional) If true, only return the total number of files that satisfy this query.
  ## `ids_only` : bool — (Optional) If true, only return the published file ids of files that satisfy this query.
  ## `return_vote_data` : bool — Return vote data
  ## `return_tags` : bool — Return tags in the file details
  ## `return_kv_tags` : bool — Return key-value tags in the file details
  ## `return_previews` : bool — Return preview image and video details in the file details
  ## `return_children` : bool — Return child item ids in the file details
  ## `return_short_description` : bool — Populate the short_description field instead of file_description
  ## `return_for_sale_data` : bool — Return pricing information, if applicable
  ## `return_metadata` : bool — Populate the metadata
  ## `return_playtime_stats` : uint32 — Return playtime stats for the specified number of days before today.
  ## `return_details` : bool — By default, if none of the other 'return_*' fields are set, only some voting details are returned. Set this to true to return the default set of details.
  ## `strip_description_bbcode` : bool — Strips BBCode from descriptions.
  ## `desired_revision` : int — Return the data for the specified revision.
  ## `return_reactions` : bool — If true, then reactions to items will be returned.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryFiles/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetDetailsV1`*(interfacename: IPublishedFileService, `key`: string, `publishedfileids`: uint64, `includetags`: bool, `includeadditionalpreviews`: bool, `includechildren`: bool, `includekvtags`: bool, `includevotes`: bool, `short_description`: bool, `includeforsaledata`: bool, `includemetadata`: bool, `language`: int32, `return_playtime_stats`: uint32, `appid`: uint32, `strip_description_bbcode`: bool, `desired_revision`: int, `includereactions`: bool): string = 
  ## Retrieves information about a set of published files.
  ## `key` : string — Access key
  ## `publishedfileids` : uint64 — Set of published file Ids to retrieve details for.
  ## `includetags` : bool — If true, return tag information in the returned details.
  ## `includeadditionalpreviews` : bool — If true, return preview information in the returned details.
  ## `includechildren` : bool — If true, return children in the returned details.
  ## `includekvtags` : bool — If true, return key value tags in the returned details.
  ## `includevotes` : bool — If true, return vote data in the returned details.
  ## `short_description` : bool — If true, return a short description instead of the full description.
  ## `includeforsaledata` : bool — If true, return pricing data, if applicable.
  ## `includemetadata` : bool — If true, populate the metadata field.
  ## `language` : int32 — Specifies the localized text to return. Defaults to English.
  ## `return_playtime_stats` : uint32 — Return playtime stats for the specified number of days before today.
  ## `strip_description_bbcode` : bool — Strips BBCode from descriptions.
  ## `desired_revision` : int — Return the data for the specified revision.
  ## `includereactions` : bool — If true, then reactions to items will be returned.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetDetails/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetUserFilesV1`*(interfacename: IPublishedFileService, `key`: string, `steamid`: uint64, `appid`: uint32, `page`: uint32, `numperpage`: uint32, `type`: string, `sortmethod`: string, `privacy`: uint32, `requiredtags`: string, `excludedtags`: string, `required_kv_tags`: Message, `filetype`: uint32, `creator_appid`: uint32, `match_cloud_filename`: string, `cache_max_age_seconds`: uint32, `language`: int32, `taggroups`: Message, `totalonly`: bool, `ids_only`: bool, `return_vote_data`: bool, `return_tags`: bool, `return_kv_tags`: bool, `return_previews`: bool, `return_children`: bool, `return_short_description`: bool, `return_for_sale_data`: bool, `return_metadata`: bool, `return_playtime_stats`: uint32, `strip_description_bbcode`: bool, `return_reactions`: bool, `startindex_override`: uint32, `desired_revision`: int): string = 
  ## Retrieves files published by a user.
  ## `key` : string — Access key
  ## `steamid` : uint64 — Steam ID of the user whose files are being requested.
  ## `appid` : uint32 — App Id of the app that the files were published to.
  ## `page` : uint32 — (Optional) Starting page for results.
  ## `numperpage` : uint32 — (Optional) The number of results, per page to return.
  ## `type` : string — (Optional) Type of files to be returned.
  ## `sortmethod` : string — (Optional) Sorting method to use on returned values.
  ## `privacy` : uint32 — (optional) Filter by privacy settings.
  ## `requiredtags` : string — (Optional) Tags that must be present on a published file to satisfy the query.
  ## `excludedtags` : string — (Optional) Tags that must NOT be present on a published file to satisfy the query.
  ## `required_kv_tags` : Message — Required key-value tags to match on.
  ## `filetype` : uint32 — (Optional) File type to match files to.
  ## `creator_appid` : uint32 — App Id of the app that published the files, only matched if specified.
  ## `match_cloud_filename` : string — Match this cloud filename if specified.
  ## `cache_max_age_seconds` : uint32 — Allow stale data to be returned for the specified number of seconds.
  ## `language` : int32 — Specifies the localized text to return. Defaults to English.
  ## `taggroups` : Message — (Optional) At least one of the tags must be present on a published file to satisfy the query.
  ## `totalonly` : bool — (Optional) If true, only return the total number of files that satisfy this query.
  ## `ids_only` : bool — (Optional) If true, only return the published file ids of files that satisfy this query.
  ## `return_vote_data` : bool — Return vote data
  ## `return_tags` : bool — Return tags in the file details
  ## `return_kv_tags` : bool — Return key-value tags in the file details
  ## `return_previews` : bool — Return preview image and video details in the file details
  ## `return_children` : bool — Return child item ids in the file details
  ## `return_short_description` : bool — Populate the short_description field instead of file_description
  ## `return_for_sale_data` : bool — Return pricing information, if applicable
  ## `return_metadata` : bool — Populate the metadata field
  ## `return_playtime_stats` : uint32 — Return playtime stats for the specified number of days before today.
  ## `strip_description_bbcode` : bool — Strips BBCode from descriptions.
  ## `return_reactions` : bool — If true, then reactions to items will be returned.
  ## `startindex_override` : uint32 — Backwards compatible for the client.
  ## `desired_revision` : int — Return the data for the specified revision.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserFiles/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeHistoryV1`*(interfacename: IEconService, `key`: string, `max_trades`: uint32, `start_after_time`: uint32, `start_after_tradeid`: uint64, `navigating_back`: bool, `get_descriptions`: bool, `language`: string, `include_failed`: bool, `include_total`: bool): string = 
  ## Gets a history of trades
  ## `key` : string — Access key
  ## `max_trades` : uint32 — The number of trades to return information for
  ## `start_after_time` : uint32 — The time of the last trade shown on the previous page of results, or the time of the first trade if navigating back
  ## `start_after_tradeid` : uint64 — The tradeid shown on the previous page of results, or the ID of the first trade if navigating back
  ## `navigating_back` : bool — The user wants the previous page of results, so return the previous max_trades trades before the start time and ID
  ## `get_descriptions` : bool — If set, the item display data for the items included in the returned trades will also be returned
  ## `language` : string — The language to use when loading item display data
  ## `include_total` : bool — If set, the total number of trades the account has participated in will be included in the response
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeHistory/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeStatusV1`*(interfacename: IEconService, `key`: string, `tradeid`: uint64, `get_descriptions`: bool, `language`: string): string = 
  ## Gets status for a specific trade
  ## `key` : string — Access key
  ## `get_descriptions` : bool — If set, the item display data for the items included in the returned trades will also be returned
  ## `language` : string — The language to use when loading item display data
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeStatus/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeOffersV1`*(interfacename: IEconService, `key`: string, `get_sent_offers`: bool, `get_received_offers`: bool, `get_descriptions`: bool, `language`: string, `active_only`: bool, `historical_only`: bool, `time_historical_cutoff`: uint32, `cursor`: uint32): string = 
  ## Get a list of sent or received trade offers
  ## `key` : string — Access key
  ## `get_sent_offers` : bool — Request the list of sent offers.
  ## `get_received_offers` : bool — Request the list of received offers.
  ## `get_descriptions` : bool — If set, the item display data for the items included in the returned trade offers will also be returned. If one or more descriptions can't be retrieved, then your request will fail.
  ## `language` : string — The language to use when loading item display data.
  ## `active_only` : bool — Indicates we should only return offers which are still active, or offers that have changed in state since the time_historical_cutoff
  ## `historical_only` : bool — Indicates we should only return offers which are not active.
  ## `time_historical_cutoff` : uint32 — When active_only is set, offers updated since this time will also be returned
  ## `cursor` : uint32 — Cursor aka start index
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffers/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeOfferV1`*(interfacename: IEconService, `key`: string, `tradeofferid`: uint64, `language`: string, `get_descriptions`: bool): string = 
  ## Gets a specific trade offer
  ## `key` : string — Access key
  ## `get_descriptions` : bool — If set, the item display data for the items included in the returned trade offers will also be returned. If one or more descriptions can't be retrieved, then your request will fail.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffer/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeOffersSummaryV1`*(interfacename: IEconService, `key`: string, `time_last_visit`: uint32): string = 
  ## Get counts of pending and new trade offers
  ## `key` : string — Access key
  ## `time_last_visit` : uint32 — The time the user last visited.  If not passed, will use the time the user last visited the trade offer page.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffersSummary/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetTradeHoldDurationsV1`*(interfacename: IEconService, `key`: string, `steamid_target`: uint64, `trade_offer_access_token`: string): string = 
  ## Returns the estimated hold duration and end date that a trade with a user would have
  ## `key` : string — Access key
  ## `steamid_target` : uint64 — User you are trading with
  ## `trade_offer_access_token` : string — A special token that allows for trade offers from non-friends.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeHoldDurations/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `UserCreateSessionV1`*(interfacename: IGameNotificationsService, `appid`: uint32, `context`: uint64, `title`: Message, `users`: Message, `steamid`: uint64): string = 
  ## Creates an async game session
  ## `appid` : uint32 — The appid to create the session for.
  ## `context` : uint64 — Game-specified context value the game can used to associate the session with some object on their backend.
  ## `title` : Message — The title of the session to be displayed within each user's list of sessions.
  ## `users` : Message — The initial state of all users in the session.
  ## `steamid` : uint64 — (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session and all users being added to the session must be friends with the user.
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserCreateSession/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `UserUpdateSessionV1`*(interfacename: IGameNotificationsService, `sessionid`: uint64, `appid`: uint32, `title`: Message, `users`: Message, `steamid`: uint64): string = 
  ## Updates an async game session
  ## `sessionid` : uint64 — The sessionid to update.
  ## `appid` : uint32 — The appid of the session to update.
  ## `title` : Message — (Optional) The new title of the session.  If not specified, the title will not be changed.
  ## `users` : Message — (Optional) A list of users whose state will be updated to reflect the given state. If the users are not already in the session, they will be added to it.
  ## `steamid` : uint64 — (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session and all users being added to the session must be friends with the user.
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserUpdateSession/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `UserDeleteSessionV1`*(interfacename: IGameNotificationsService, `sessionid`: uint64, `appid`: uint32, `steamid`: uint64): string = 
  ## Deletes an async game session
  ## `sessionid` : uint64 — The sessionid to delete.
  ## `appid` : uint32 — The appid of the session to delete.
  ## `steamid` : uint64 — (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session.
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserDeleteSession/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `SplitItemStackV1`*(interfacename: IInventoryService, `key`: string, `appid`: uint32, `itemid`: uint64, `quantity`: uint32, `steamid`: uint64): string = 
  ## Split an item stack into two stacks
  ## `key` : string — Access key
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SplitItemStack/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `CombineItemStacksV1`*(interfacename: IInventoryService, `key`: string, `appid`: uint32, `fromitemid`: uint64, `destitemid`: uint64, `quantity`: uint32, `steamid`: uint64): string = 
  ## Combine two stacks of items
  ## `key` : string — Access key
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/CombineItemStacks/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `GetPriceSheetV1`*(interfacename: IInventoryService, `key`: string, `ecurrency`: int32, `currency_code`: string): string = 
  ## Get the Inventory Service price sheet
  ## `key` : string — Access key
  ## `currency_code` : string — Standard short code of the requested currency (preferred)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPriceSheet/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `GetAppListV1`*(interfacename: IStoreService, `key`: string, `if_modified_since`: uint32, `have_description_language`: string, `include_games`: bool, `include_dlc`: bool, `include_software`: bool, `include_videos`: bool, `include_hardware`: bool, `last_appid`: uint32, `max_results`: uint32): string = 
  ## Gets a list of apps available on the Steam Store.
  ## `key` : string — Access key
  ## `if_modified_since` : uint32 — Return only items that have been modified since this date.
  ## `have_description_language` : string — Return only items that have a description in this language.
  ## `include_games` : bool — Include games (defaults to enabled)
  ## `include_dlc` : bool — Include DLC
  ## `include_software` : bool — Include software items
  ## `include_videos` : bool — Include videos and series
  ## `include_hardware` : bool — Include hardware
  ## `last_appid` : uint32 — For continuations, this is the last appid returned from the previous call.
  ## `max_results` : uint32 — Number of results to return at a time.  Default 10k, max 50k.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v1/"
  var client = newHttpClient()
  return client.getContent(url) 

proc `ReportCheatDataV1`*(interfacename: ICheatReportingService, `key`: string, `steamid`: uint64, `appid`: uint32, `pathandfilename`: string, `webcheaturl`: string, `time_now`: uint64, `time_started`: uint64, `time_stopped`: uint64, `cheatname`: string, `game_process_id`: uint32, `cheat_process_id`: uint32, `cheat_param_1`: uint64, `cheat_param_2`: uint64, `cheat_data_dump`: string): string = 
  ## Reports cheat data. Only use on test account that is running the game but not in a multiplayer session.
  ## `key` : string — Access key
  ## `steamid` : uint64 — steamid of the user running and reporting the cheat.
  ## `appid` : uint32 — The appid.
  ## `pathandfilename` : string — path and file name of the cheat executable.
  ## `webcheaturl` : string — web url where the cheat was found and downloaded.
  ## `time_now` : uint64 — local system time now.
  ## `time_started` : uint64 — local system time when cheat process started. ( 0 if not yet run )
  ## `time_stopped` : uint64 — local system time when cheat process stopped. ( 0 if still running )
  ## `cheatname` : string — descriptive name for the cheat.
  ## `game_process_id` : uint32 — process ID of the running game.
  ## `cheat_process_id` : uint32 — process ID of the cheat process that ran
  ## `cheat_param_1` : uint64 — cheat param 1
  ## `cheat_param_2` : uint64 — cheat param 2
  ## `cheat_data_dump` : string — data collection in json format
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ReportCheatData/v1/"
  var client = newHttpClient()
  return client.postContent(url, multipart=nil) 

proc `ReportEventV1`*(interfacename: AsyncIClientStats_1046930): Future[string] {.async.} = 
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ReportEvent/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetNextMatchSharingCodeV1`*(interfacename: AsyncICSGOPlayers_730, `steamid`: uint64, `steamidkey`: string, `knowncode`: string): Future[string] {.async.} = 
  ## `steamid` : uint64 — The SteamID of the user
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## `knowncode` : string — Previously known match sharing code obtained from the SteamID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNextMatchSharingCode/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGameMapsPlaytimeV1`*(interfacename: AsyncICSGOServers_730, `interval`: string, `gamemode`: string, `mapgroup`: string): Future[string] {.async.} = 
  ## `interval` : string — What recent interval is requested, possible values: day, week, month
  ## `gamemode` : string — What game mode is requested, possible values: competitive, casual
  ## `mapgroup` : string — What maps are requested, possible values: operation
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameMapsPlaytime/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGameServersStatusV1`*(interfacename: AsyncICSGOServers_730): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameServersStatus/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentFantasyLineupV1`*(interfacename: AsyncICSGOTournaments_730, `event`: uint32, `steamid`: uint64, `steamidkey`: string): Future[string] {.async.} = 
  ## `event` : uint32 — The event ID
  ## `steamid` : uint64 — The SteamID of the user inventory
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentFantasyLineup/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentItemsV1`*(interfacename: AsyncICSGOTournaments_730, `event`: uint32, `steamid`: uint64, `steamidkey`: string): Future[string] {.async.} = 
  ## `event` : uint32 — The event ID
  ## `steamid` : uint64 — The SteamID of the user inventory
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentLayoutV1`*(interfacename: AsyncICSGOTournaments_730, `event`: uint32): Future[string] {.async.} = 
  ## `event` : uint32 — The event ID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentLayout/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPredictionsV1`*(interfacename: AsyncICSGOTournaments_730, `event`: uint32, `steamid`: uint64, `steamidkey`: string): Future[string] {.async.} = 
  ## `event` : uint32 — The event ID
  ## `steamid` : uint64 — The SteamID of the user inventory
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPredictions/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `UploadTournamentFantasyLineupV1`*(interfacename: AsyncICSGOTournaments_730, `event`: uint32, `steamid`: uint64, `steamidkey`: string, `sectionid`: uint32, `pickid0`: uint32, `itemid0`: uint64, `pickid1`: uint32, `itemid1`: uint64, `pickid2`: uint32, `itemid2`: uint64, `pickid3`: uint32, `itemid3`: uint64, `pickid4`: uint32, `itemid4`: uint64): Future[string] {.async.} = 
  ## `event` : uint32 — The event ID
  ## `steamid` : uint64 — The SteamID of the user inventory
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## `sectionid` : uint32 — Event section id
  ## `pickid0` : uint32 — PickID to select for the slot
  ## `itemid0` : uint64 — ItemID to lock in for the pick
  ## `pickid1` : uint32 — PickID to select for the slot
  ## `itemid1` : uint64 — ItemID to lock in for the pick
  ## `pickid2` : uint32 — PickID to select for the slot
  ## `itemid2` : uint64 — ItemID to lock in for the pick
  ## `pickid3` : uint32 — PickID to select for the slot
  ## `itemid3` : uint64 — ItemID to lock in for the pick
  ## `pickid4` : uint32 — PickID to select for the slot
  ## `itemid4` : uint64 — ItemID to lock in for the pick
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UploadTournamentFantasyLineup/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `UploadTournamentPredictionsV1`*(interfacename: AsyncICSGOTournaments_730, `event`: uint32, `steamid`: uint64, `steamidkey`: string, `sectionid`: uint32, `groupid`: uint32, `index`: uint32, `pickid`: uint32, `itemid`: uint64): Future[string] {.async.} = 
  ## `event` : uint32 — The event ID
  ## `steamid` : uint64 — The SteamID of the user inventory
  ## `steamidkey` : string — Authentication obtained from the SteamID
  ## `sectionid` : uint32 — Event section id
  ## `groupid` : uint32 — Event group id
  ## `index` : uint32 — Index in group
  ## `pickid` : uint32 — Pick ID to select
  ## `itemid` : uint64 — ItemID to lock in for the pick
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UploadTournamentPredictions/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetFantasyPlayerStatsV1`*(interfacename: AsyncIDOTA2Fantasy_205790, `FantasyLeagueID`: uint32, `StartTime`: uint32, `EndTime`: uint32, `MatchID`: uint64, `SeriesID`: uint32, `PlayerAccountID`: uint32): Future[string] {.async.} = 
  ## `FantasyLeagueID` : uint32 — The fantasy league ID
  ## `StartTime` : uint32 — An optional filter for minimum timestamp
  ## `EndTime` : uint32 — An optional filter for maximum timestamp
  ## `MatchID` : uint64 — An optional filter for a specific match
  ## `SeriesID` : uint32 — An optional filter for a specific series
  ## `PlayerAccountID` : uint32 — An optional filter for a specific player
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetFantasyPlayerStats/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerOfficialInfoV1`*(interfacename: AsyncIDOTA2Fantasy_205790, `accountid`: uint32): Future[string] {.async.} = 
  ## `accountid` : uint32 — The account ID to look up
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerOfficialInfo/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetProPlayerListV1`*(interfacename: AsyncIDOTA2Fantasy_205790): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetProPlayerList/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetRealtimeStatsV1`*(interfacename: AsyncIDOTA2MatchStats_205790, `server_steam_id`: uint64): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRealtimeStats/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetRealtimeStatsV1`*(interfacename: AsyncIDOTA2MatchStats_570, `server_steam_id`: uint64): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRealtimeStats/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetLeagueListingV1`*(interfacename: AsyncIDOTA2Match_205790): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLeagueListing/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetLiveLeagueGamesV1`*(interfacename: AsyncIDOTA2Match_205790, `league_id`: uint32, `match_id`: uint64): Future[string] {.async.} = 
  ## `league_id` : uint32 — Only show matches of the specified league id
  ## `match_id` : uint64 — Only show matches of the specified match id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLiveLeagueGames/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchDetailsV1`*(interfacename: AsyncIDOTA2Match_205790, `match_id`: uint64): Future[string] {.async.} = 
  ## `match_id` : uint64 — Match id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchDetails/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchHistoryV1`*(interfacename: AsyncIDOTA2Match_205790, `hero_id`: uint32, `game_mode`: uint32, `skill`: uint32, `min_players`: string, `account_id`: string, `league_id`: string, `start_at_match_id`: uint64, `matches_requested`: string): Future[string] {.async.} = 
  ## `hero_id` : uint32 — The ID of the hero that must be in the matches being queried
  ## `game_mode` : uint32 — Which game mode to return matches for
  ## `skill` : uint32 — The average skill range of the match, these can be [1-3] with lower numbers being lower skill. Ignored if an account ID is specified
  ## `min_players` : string — Minimum number of human players that must be in a match for it to be returned
  ## `account_id` : string — An account ID to get matches from. This will fail if the user has their match history hidden
  ## `league_id` : string — The league ID to return games from
  ## `start_at_match_id` : uint64 — The minimum match ID to start from
  ## `matches_requested` : string — The number of requested matches to return
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistory/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchHistoryBySequenceNumV1`*(interfacename: AsyncIDOTA2Match_205790, `start_at_match_seq_num`: uint64, `matches_requested`: uint32): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistoryBySequenceNum/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTeamInfoByTeamIDV1`*(interfacename: AsyncIDOTA2Match_205790, `start_at_team_id`: uint64, `teams_requested`: uint32): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTeamInfoByTeamID/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopLiveEventGameV1`*(interfacename: AsyncIDOTA2Match_205790, `partner`: int32): Future[string] {.async.} = 
  ## `partner` : int32 — Which partner's games to use.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveEventGame/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopLiveGameV1`*(interfacename: AsyncIDOTA2Match_205790, `partner`: int32): Future[string] {.async.} = 
  ## `partner` : int32 — Which partner's games to use.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveGame/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopWeekendTourneyGamesV1`*(interfacename: AsyncIDOTA2Match_205790, `partner`: int32, `home_division`: int32): Future[string] {.async.} = 
  ## `partner` : int32 — Which partner's games to use.
  ## `home_division` : int32 — Prefer matches from this division.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopWeekendTourneyGames/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPlayerStatsV1`*(interfacename: AsyncIDOTA2Match_205790, `account_id`: string, `league_id`: string, `hero_id`: string, `time_frame`: string, `match_id`: uint64, `phase_id`: uint32): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPlayerStatsV2`*(interfacename: AsyncIDOTA2Match_205790, `account_id`: string, `league_id`: string, `hero_id`: string, `time_frame`: string, `match_id`: uint64, `phase_id`: uint32): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetLiveLeagueGamesV1`*(interfacename: AsyncIDOTA2Match_570, `league_id`: uint32, `match_id`: uint64, `dpc`: bool): Future[string] {.async.} = 
  ## `league_id` : uint32 — Only show matches of the specified league id
  ## `match_id` : uint64 — Only show matches of the specified match id
  ## `dpc` : bool — Only show matches that are part of the DPC
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetLiveLeagueGames/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchDetailsV1`*(interfacename: AsyncIDOTA2Match_570, `match_id`: uint64, `include_persona_names`: bool): Future[string] {.async.} = 
  ## `match_id` : uint64 — Match id
  ## `include_persona_names` : bool — Include persona names as part of the response
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchDetails/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchHistoryV1`*(interfacename: AsyncIDOTA2Match_570, `hero_id`: uint32, `game_mode`: uint32, `skill`: uint32, `min_players`: string, `account_id`: string, `league_id`: string, `start_at_match_id`: uint64, `matches_requested`: string): Future[string] {.async.} = 
  ## `hero_id` : uint32 — The ID of the hero that must be in the matches being queried
  ## `game_mode` : uint32 — Which game mode to return matches for
  ## `skill` : uint32 — The average skill range of the match, these can be [1-3] with lower numbers being lower skill. Ignored if an account ID is specified
  ## `min_players` : string — Minimum number of human players that must be in a match for it to be returned
  ## `account_id` : string — An account ID to get matches from. This will fail if the user has their match history hidden
  ## `league_id` : string — The league ID to return games from
  ## `start_at_match_id` : uint64 — The minimum match ID to start from
  ## `matches_requested` : string — The number of requested matches to return
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistory/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetMatchHistoryBySequenceNumV1`*(interfacename: AsyncIDOTA2Match_570, `start_at_match_seq_num`: uint64, `matches_requested`: uint32): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetMatchHistoryBySequenceNum/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTeamInfoByTeamIDV1`*(interfacename: AsyncIDOTA2Match_570, `start_at_team_id`: uint64, `teams_requested`: uint32): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTeamInfoByTeamID/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopLiveEventGameV1`*(interfacename: AsyncIDOTA2Match_570, `partner`: int32): Future[string] {.async.} = 
  ## `partner` : int32 — Which partner's games to use.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveEventGame/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopLiveGameV1`*(interfacename: AsyncIDOTA2Match_570, `partner`: int32): Future[string] {.async.} = 
  ## `partner` : int32 — Which partner's games to use.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopLiveGame/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTopWeekendTourneyGamesV1`*(interfacename: AsyncIDOTA2Match_570, `partner`: int32, `home_division`: int32): Future[string] {.async.} = 
  ## `partner` : int32 — Which partner's games to use.
  ## `home_division` : int32 — Prefer matches from this division.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTopWeekendTourneyGames/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPlayerStatsV1`*(interfacename: AsyncIDOTA2Match_570, `account_id`: string, `league_id`: string, `hero_id`: string, `time_frame`: string, `match_id`: uint64): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPlayerStatsV2`*(interfacename: AsyncIDOTA2Match_570, `account_id`: string, `league_id`: string, `hero_id`: string, `time_frame`: string, `match_id`: uint64, `phase_id`: uint32): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPlayerStats/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetBroadcasterInfoV1`*(interfacename: AsyncIDOTA2StreamSystem_205790, `broadcaster_steam_id`: uint64, `league_id`: uint32): Future[string] {.async.} = 
  ## `broadcaster_steam_id` : uint64 — 64-bit Steam ID of the broadcaster
  ## `league_id` : uint32 — LeagueID to use if we aren't in a lobby
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBroadcasterInfo/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetBroadcasterInfoV1`*(interfacename: AsyncIDOTA2StreamSystem_570, `broadcaster_steam_id`: uint64, `league_id`: uint32): Future[string] {.async.} = 
  ## `broadcaster_steam_id` : uint64 — 64-bit Steam ID of the broadcaster
  ## `league_id` : uint32 — LeagueID to use if we aren't in a lobby
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBroadcasterInfo/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `ClaimBadgeRewardV1`*(interfacename: AsyncIDOTA2Ticket_205790, `BadgeID`: string, `ValidBadgeType1`: uint32, `ValidBadgeType2`: uint32, `ValidBadgeType3`: uint32): Future[string] {.async.} = 
  ## `BadgeID` : string — The Badge ID
  ## `ValidBadgeType1` : uint32 — Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — Valid Badge Type 3
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ClaimBadgeReward/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSteamIDForBadgeIDV1`*(interfacename: AsyncIDOTA2Ticket_205790, `BadgeID`: string): Future[string] {.async.} = 
  ## `BadgeID` : string — The badge ID
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamIDForBadgeID/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `SetSteamAccountPurchasedV1`*(interfacename: AsyncIDOTA2Ticket_205790, `steamid`: uint64, `BadgeType`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — The 64-bit Steam ID
  ## `BadgeType` : uint32 — Badge Type
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamAccountPurchased/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `SteamAccountValidForBadgeTypeV1`*(interfacename: AsyncIDOTA2Ticket_205790, `steamid`: uint64, `ValidBadgeType1`: uint32, `ValidBadgeType2`: uint32, `ValidBadgeType3`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — The 64-bit Steam ID
  ## `ValidBadgeType1` : uint32 — Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — Valid Badge Type 3
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/SteamAccountValidForBadgeType/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `SetSteamAccountPurchasedV1`*(interfacename: AsyncIDOTA2Ticket_570, `SteamID`: uint64, `BadgeType`: uint32): Future[string] {.async.} = 
  ## `SteamID` : uint64 — The 64-bit Steam ID
  ## `BadgeType` : uint32 — Badge Type
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamAccountPurchased/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `SteamAccountValidForBadgeTypeV1`*(interfacename: AsyncIDOTA2Ticket_570, `SteamID`: uint64, `ValidBadgeType1`: uint32, `ValidBadgeType2`: uint32, `ValidBadgeType3`: uint32): Future[string] {.async.} = 
  ## `SteamID` : uint64 — The 64-bit Steam ID
  ## `ValidBadgeType1` : uint32 — Valid Badge Type 1
  ## `ValidBadgeType2` : uint32 — Valid Badge Type 2
  ## `ValidBadgeType3` : uint32 — Valid Badge Type 3
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/SteamAccountValidForBadgeType/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEventStatsForAccountV1`*(interfacename: AsyncIEconDOTA2_205790, `eventid`: uint32, `accountid`: uint32, `language`: string): Future[string] {.async.} = 
  ## `eventid` : uint32 — The League ID of the compendium you're looking for.
  ## `accountid` : uint32 — The account ID to look up.
  ## `language` : string — The language to provide hero names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEventStatsForAccount/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGameItemsV1`*(interfacename: AsyncIEconDOTA2_205790, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to provide item names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetHeroesV1`*(interfacename: AsyncIEconDOTA2_205790, `language`: string, `itemizedonly`: bool): Future[string] {.async.} = 
  ## `language` : string — The language to provide hero names in.
  ## `itemizedonly` : bool — Return a list of itemized heroes only.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetHeroes/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetItemIconPathV1`*(interfacename: AsyncIEconDOTA2_205790, `iconname`: string, `icontype`: uint32): Future[string] {.async.} = 
  ## `iconname` : string — The item icon name to get the CDN path of
  ## `icontype` : uint32 — The type of image you want. 0 = normal, 1 = large, 2 = ingame
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemIconPath/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetRaritiesV1`*(interfacename: AsyncIEconDOTA2_205790, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to provide rarity names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRarities/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPrizePoolV1`*(interfacename: AsyncIEconDOTA2_205790, `leagueid`: uint32): Future[string] {.async.} = 
  ## `leagueid` : uint32 — The ID of the league to get the prize pool of
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPrizePool/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEventStatsForAccountV1`*(interfacename: AsyncIEconDOTA2_570, `eventid`: uint32, `accountid`: uint32, `language`: string): Future[string] {.async.} = 
  ## `eventid` : uint32 — The Event ID of the event you're looking for.
  ## `accountid` : uint32 — The account ID to look up.
  ## `language` : string — The language to provide hero names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEventStatsForAccount/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGameItemsV1`*(interfacename: AsyncIEconDOTA2_570, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to provide item names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGameItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetHeroesV1`*(interfacename: AsyncIEconDOTA2_570, `language`: string, `itemizedonly`: bool): Future[string] {.async.} = 
  ## `language` : string — The language to provide hero names in.
  ## `itemizedonly` : bool — Return a list of itemized heroes only.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetHeroes/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetItemCreatorsV1`*(interfacename: AsyncIEconDOTA2_570, `itemdef`: uint32): Future[string] {.async.} = 
  ## `itemdef` : uint32 — The item definition to get creator information for.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemCreators/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetItemWorkshopPublishedFileIDsV1`*(interfacename: AsyncIEconDOTA2_570, `itemdef`: uint32): Future[string] {.async.} = 
  ## `itemdef` : uint32 — The item definition to get published file ids for.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemWorkshopPublishedFileIDs/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetRaritiesV1`*(interfacename: AsyncIEconDOTA2_570, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to provide rarity names in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRarities/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTournamentPrizePoolV1`*(interfacename: AsyncIEconDOTA2_570, `leagueid`: uint32): Future[string] {.async.} = 
  ## `leagueid` : uint32 — The ID of the league to get the prize pool of
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTournamentPrizePool/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_1046930, `steamid`: uint64): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: AsyncIEconItems_1269260, `steamid`: uint64, `class_id`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `class_id` : uint32 — Return items equipped for this class id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: AsyncIEconItems_205790, `steamid`: uint64, `class_id`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `class_id` : uint32 — Return items equipped for this class id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_205790, `steamid`: uint64): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaURLV1`*(interfacename: AsyncIEconItems_205790): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: AsyncIEconItems_205790, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to results in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_221540, `steamid`: uint64): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_238460, `steamid`: uint64): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_440, `steamid`: uint64): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaV1`*(interfacename: AsyncIEconItems_440, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to return the names in. Defaults to returning string keys.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaItemsV1`*(interfacename: AsyncIEconItems_440, `language`: string, `start`: int32): Future[string] {.async.} = 
  ## `language` : string — The language to return the names in. Defaults to returning string keys.
  ## `start` : int32 — The first item id to return. Defaults to 0. Response will indicate next value to query if applicable.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaOverviewV1`*(interfacename: AsyncIEconItems_440, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to return the names in. Defaults to returning string keys.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaOverview/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaURLV1`*(interfacename: AsyncIEconItems_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: AsyncIEconItems_440, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to results in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetStoreStatusV1`*(interfacename: AsyncIEconItems_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreStatus/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: AsyncIEconItems_570, `SteamID`: uint64, `class_id`: uint32): Future[string] {.async.} = 
  ## `SteamID` : uint64 — The Steam ID to fetch items for
  ## `class_id` : uint32 — Return items equipped for this class id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_570, `SteamID`: uint64): Future[string] {.async.} = 
  ## `SteamID` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: AsyncIEconItems_570, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to results in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetEquippedPlayerItemsV1`*(interfacename: AsyncIEconItems_583950, `steamid`: uint64, `class_id`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `class_id` : uint32 — Return items equipped for this class id
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetEquippedPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_620, `steamid`: uint64): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaV1`*(interfacename: AsyncIEconItems_620, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to return the names in. Defaults to returning string keys.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerItemsV1`*(interfacename: AsyncIEconItems_730, `steamid`: uint64): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerItems/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaV2`*(interfacename: AsyncIEconItems_730, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to return the names in. Defaults to returning string keys.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchema/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaURLV2`*(interfacename: AsyncIEconItems_730): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaURL/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetStoreMetaDataV1`*(interfacename: AsyncIEconItems_730, `language`: string): Future[string] {.async.} = 
  ## `language` : string — The language to results in.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetStoreMetaData/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_1046930): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_1046930): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_1269260): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_1269260): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_205790): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_205790): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_570): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_570): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientVersionV1`*(interfacename: AsyncIGCVersion_583950): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_583950): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerVersionV1`*(interfacename: AsyncIGCVersion_730): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerVersion/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetBucketizedDataV1`*(interfacename: AsyncIPortal2Leaderboards_620, `leaderboardName`: string): Future[string] {.async.} = 
  ## `leaderboardName` : string — The leaderboard name to fetch data for.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBucketizedData/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAppListV1`*(interfacename: AsyncISteamApps): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAppListV2`*(interfacename: AsyncISteamApps): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSDRConfigV1`*(interfacename: AsyncISteamApps, `appid`: uint32): Future[string] {.async.} = 
  ## `appid` : uint32 — AppID of game
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSDRConfig/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServersAtAddressV1`*(interfacename: AsyncISteamApps, `addr`: string): Future[string] {.async.} = 
  ## `addr` : string — IP or IP:queryport to list
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServersAtAddress/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `UpToDateCheckV1`*(interfacename: AsyncISteamApps, `appid`: uint32, `version`: uint32): Future[string] {.async.} = 
  ## `appid` : uint32 — AppID of game
  ## `version` : uint32 — The installed version of the game
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/UpToDateCheck/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `ViewerHeartbeatV1`*(interfacename: AsyncISteamBroadcast, `steamid`: uint64, `sessionid`: uint64, `token`: uint64, `stream`: int32): Future[string] {.async.} = 
  ## `steamid` : uint64 — Steam ID of the broadcaster
  ## `sessionid` : uint64 — Broadcast Session ID
  ## `token` : uint64 — Viewer token
  ## `stream` : int32 — video stream representation watching
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ViewerHeartbeat/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `SetClientFiltersV1`*(interfacename: AsyncISteamCDN, `key`: string, `cdnname`: string, `allowedipblocks`: string, `allowedasns`: string, `allowedipcountries`: string): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `cdnname` : string — Steam name of CDN property
  ## `allowedipblocks` : string — comma-separated list of allowed IP address blocks in CIDR format - blank for not used
  ## `allowedasns` : string — comma-separated list of allowed client network AS numbers - blank for not used
  ## `allowedipcountries` : string — comma-separated list of allowed client IP country codes in ISO 3166-1 format - blank for not used
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetClientFilters/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `SetPerformanceStatsV1`*(interfacename: AsyncISteamCDN, `key`: string, `cdnname`: string, `mbps_sent`: uint32, `mbps_recv`: uint32, `cpu_percent`: uint32, `cache_hit_percent`: uint32): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `cdnname` : string — Steam name of CDN property
  ## `mbps_sent` : uint32 — Outgoing network traffic in Mbps
  ## `mbps_recv` : uint32 — Incoming network traffic in Mbps
  ## `cpu_percent` : uint32 — Percent CPU load
  ## `cache_hit_percent` : uint32 — Percent cache hits
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetPerformanceStats/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetCMListV1`*(interfacename: AsyncISteamDirectory, `cellid`: uint32, `maxcount`: uint32): Future[string] {.async.} = 
  ## `cellid` : uint32 — Client's Steam cell ID
  ## `maxcount` : uint32 — Max number of servers to return
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCMList/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetCMListForConnectV1`*(interfacename: AsyncISteamDirectory, `cellid`: uint32, `cmtype`: string, `realm`: string, `maxcount`: uint32): Future[string] {.async.} = 
  ## `cellid` : uint32 — Client's Steam cell ID, uses IP location if blank
  ## `cmtype` : string — Optional CM type filter
  ## `realm` : string — Optional Steam Realm filter
  ## `maxcount` : uint32 — Max number of servers to return
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCMListForConnect/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSteamPipeDomainsV1`*(interfacename: AsyncISteamDirectory): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamPipeDomains/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAssetClassInfoV1`*(interfacename: AsyncISteamEconomy, `appid`: uint32, `language`: string, `class_count`: uint32, `classid0`: uint64, `instanceid0`: uint64): Future[string] {.async.} = 
  ## `appid` : uint32 — Must be a steam economy app.
  ## `language` : string — The user's local language
  ## `class_count` : uint32 — Number of classes requested. Must be at least one.
  ## `classid0` : uint64 — Class ID of the nth class.
  ## `instanceid0` : uint64 — Instance ID of the nth class.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAssetClassInfo/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAssetPricesV1`*(interfacename: AsyncISteamEconomy, `appid`: uint32, `currency`: string, `language`: string): Future[string] {.async.} = 
  ## `appid` : uint32 — Must be a steam economy app.
  ## `currency` : string — The currency to filter for
  ## `language` : string — The user's local language
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAssetPrices/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetNewsForAppV1`*(interfacename: AsyncISteamNews, `appid`: uint32, `maxlength`: uint32, `enddate`: uint32, `count`: uint32, `tags`: string): Future[string] {.async.} = 
  ## `appid` : uint32 — AppID to retrieve news for
  ## `maxlength` : uint32 — Maximum length for the content to return, if this is 0 the full content is returned, if it's less then a blurb is generated to fit.
  ## `enddate` : uint32 — Retrieve posts earlier than this date (unix epoch timestamp)
  ## `count` : uint32 — # of posts to retrieve (default 20)
  ## `tags` : string — Comma-separated list of tags to filter by (e.g. 'patchnodes')
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNewsForApp/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetNewsForAppV2`*(interfacename: AsyncISteamNews, `appid`: uint32, `maxlength`: uint32, `enddate`: uint32, `count`: uint32, `feeds`: string, `tags`: string): Future[string] {.async.} = 
  ## `appid` : uint32 — AppID to retrieve news for
  ## `maxlength` : uint32 — Maximum length for the content to return, if this is 0 the full content is returned, if it's less then a blurb is generated to fit.
  ## `enddate` : uint32 — Retrieve posts earlier than this date (unix epoch timestamp)
  ## `count` : uint32 — # of posts to retrieve (default 20)
  ## `feeds` : string — Comma-separated list of feed names to return news for
  ## `tags` : string — Comma-separated list of tags to filter by (e.g. 'patchnodes')
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNewsForApp/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetCollectionDetailsV1`*(interfacename: AsyncISteamRemoteStorage, `collectioncount`: uint32, `publishedfileids`: seq[uint64]): Future[string] {.async.} = 
  ## `collectioncount` : uint32 — Number of collections being requested
  ## `publishedfileids[0]` : uint64 — collection ids to get the details for
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCollectionDetails/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetPublishedFileDetailsV1`*(interfacename: AsyncISteamRemoteStorage, `itemcount`: uint32, `publishedfileids`: seq[uint64]): Future[string] {.async.} = 
  ## `itemcount` : uint32 — Number of items being requested
  ## `publishedfileids[0]` : uint64 — published file id to look up
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPublishedFileDetails/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetUGCFileDetailsV1`*(interfacename: AsyncISteamRemoteStorage, `steamid`: uint64, `ugcid`: uint64, `appid`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — If specified, only returns details if the file is owned by the SteamID specified
  ## `ugcid` : uint64 — ID of UGC file to get info for
  ## `appid` : uint32 — appID of product
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUGCFileDetails/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetFriendListV1`*(interfacename: AsyncISteamUser, `key`: string, `steamid`: uint64, `relationship`: string): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `steamid` : uint64 — SteamID of user
  ## `relationship` : string — relationship type (ex: friend)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetFriendList/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerBansV1`*(interfacename: AsyncISteamUser, `key`: string, `steamids`: string): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `steamids` : string — Comma-delimited list of SteamIDs
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerBans/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerSummariesV1`*(interfacename: AsyncISteamUser, `key`: string, `steamids`: string): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `steamids` : string — Comma-delimited list of SteamIDs
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerSummaries/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerSummariesV2`*(interfacename: AsyncISteamUser, `key`: string, `steamids`: string): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `steamids` : string — Comma-delimited list of SteamIDs (max: 100)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerSummaries/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetUserGroupListV1`*(interfacename: AsyncISteamUser, `key`: string, `steamid`: uint64): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `steamid` : uint64 — SteamID of user
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserGroupList/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `ResolveVanityURLV1`*(interfacename: AsyncISteamUser, `key`: string, `vanityurl`: string, `url_type`: int32): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `vanityurl` : string — The vanity URL to get a SteamID for
  ## `url_type` : int32 — The type of vanity URL. 1 (default): Individual profile, 2: Group, 3: Official game group
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/ResolveVanityURL/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `AuthenticateUserV1`*(interfacename: AsyncISteamUserAuth, `steamid`: uint64, `sessionkey`: Rawbinary, `encrypted_loginkey`: Rawbinary): Future[string] {.async.} = 
  ## `steamid` : uint64 — Should be the users steamid, unencrypted.
  ## `sessionkey` : Rawbinary — Should be a 32 byte random blob of data, which is then encrypted with RSA using the Steam system's public key.  Randomness is important here for security.
  ## `encrypted_loginkey` : Rawbinary — Should be the users hashed loginkey, AES encrypted with the sessionkey.
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/AuthenticateUser/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `AuthenticateUserTicketV1`*(interfacename: AsyncISteamUserAuth, `key`: string, `appid`: uint32, `ticket`: string): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `appid` : uint32 — appid of game
  ## `ticket` : string — Ticket from GetAuthSessionTicket.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/AuthenticateUserTicket/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTokenDetailsV1`*(interfacename: AsyncISteamUserOAuth, `access_token`: string): Future[string] {.async.} = 
  ## `access_token` : string — OAuth2 token for which to return details
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTokenDetails/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGlobalAchievementPercentagesForAppV1`*(interfacename: AsyncISteamUserStats, `gameid`: uint64): Future[string] {.async.} = 
  ## `gameid` : uint64 — GameID to retrieve the achievement percentages for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalAchievementPercentagesForApp/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGlobalAchievementPercentagesForAppV2`*(interfacename: AsyncISteamUserStats, `gameid`: uint64): Future[string] {.async.} = 
  ## `gameid` : uint64 — GameID to retrieve the achievement percentages for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalAchievementPercentagesForApp/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGlobalStatsForGameV1`*(interfacename: AsyncISteamUserStats, `appid`: uint32, `count`: uint32, `name`: seq[string], `startdate`: uint32, `enddate`: uint32): Future[string] {.async.} = 
  ## `appid` : uint32 — AppID that we're getting global stats for
  ## `count` : uint32 — Number of stats get data for
  ## `name[0]` : string — Names of stat to get data for
  ## `startdate` : uint32 — Start date for daily totals (unix epoch timestamp)
  ## `enddate` : uint32 — End date for daily totals (unix epoch timestamp)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGlobalStatsForGame/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetNumberOfCurrentPlayersV1`*(interfacename: AsyncISteamUserStats, `appid`: uint32): Future[string] {.async.} = 
  ## `appid` : uint32 — AppID that we're getting user count for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetNumberOfCurrentPlayers/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetPlayerAchievementsV1`*(interfacename: AsyncISteamUserStats, `key`: string, `steamid`: uint64, `appid`: uint32, `l`: string): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `steamid` : uint64 — SteamID of user
  ## `appid` : uint32 — AppID to get achievements for
  ## `l` : string — Language to return strings for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPlayerAchievements/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaForGameV1`*(interfacename: AsyncISteamUserStats, `key`: string, `appid`: uint32, `l`: string): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `appid` : uint32 — appid of game
  ## `l` : string — localized langauge to return (english, french, etc.)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaForGame/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSchemaForGameV2`*(interfacename: AsyncISteamUserStats, `key`: string, `appid`: uint32, `l`: string): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `appid` : uint32 — appid of game
  ## `l` : string — localized language to return (english, french, etc.)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSchemaForGame/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetUserStatsForGameV1`*(interfacename: AsyncISteamUserStats, `key`: string, `steamid`: uint64, `appid`: uint32): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `steamid` : uint64 — SteamID of user
  ## `appid` : uint32 — appid of game
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserStatsForGame/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetUserStatsForGameV2`*(interfacename: AsyncISteamUserStats, `key`: string, `steamid`: uint64, `appid`: uint32): Future[string] {.async.} = 
  ## `key` : string — access key
  ## `steamid` : uint64 — SteamID of user
  ## `appid` : uint32 — appid of game
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserStatsForGame/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerInfoV1`*(interfacename: AsyncISteamWebAPIUtil): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerInfo/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSupportedAPIListV1`*(interfacename: AsyncISteamWebAPIUtil, `key`: string): Future[string] {.async.} = 
  ## `key` : string — access key
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSupportedAPIList/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `PollStatusV1`*(interfacename: AsyncISteamWebUserPresenceOAuth, `steamid`: string, `umqid`: uint64, `message`: uint32, `pollid`: uint32, `sectimeout`: uint32, `secidletime`: uint32, `use_accountids`: uint32): Future[string] {.async.} = 
  ## `steamid` : string — Steam ID of the user
  ## `umqid` : uint64 — UMQ Session ID
  ## `message` : uint32 — Message that was last known to the user
  ## `pollid` : uint32 — Caller-specific poll id
  ## `sectimeout` : uint32 — Long-poll timeout in seconds
  ## `secidletime` : uint32 — How many seconds is client considering itself idle, e.g. screen is off
  ## `use_accountids` : uint32 — Boolean, 0 (default): return steamid_from in output, 1: return accountid_from
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/PollStatus/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetGoldenWrenchesV1`*(interfacename: AsyncITFItems_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGoldenWrenches/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetGoldenWrenchesV2`*(interfacename: AsyncITFItems_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetGoldenWrenches/v2/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetItemIDV1`*(interfacename: AsyncITFPromos_205790, `steamid`: uint64, `promoid`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `promoid` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GrantItemV1`*(interfacename: AsyncITFPromos_205790, `steamid`: uint64, `promoid`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `promoid` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetItemIDV1`*(interfacename: AsyncITFPromos_440, `steamid`: uint64, `promoid`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `promoid` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GrantItemV1`*(interfacename: AsyncITFPromos_440, `steamid`: uint64, `promoid`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `promoid` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetItemIDV1`*(interfacename: AsyncITFPromos_620, `steamid`: uint64, `PromoID`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `PromoID` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetItemID/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GrantItemV1`*(interfacename: AsyncITFPromos_620, `steamid`: uint64, `PromoID`: uint32): Future[string] {.async.} = 
  ## `steamid` : uint64 — The Steam ID to fetch items for
  ## `PromoID` : uint32 — The promo ID to grant an item for
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/GrantItem/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetWorldStatusV1`*(interfacename: AsyncITFSystem_440): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetWorldStatus/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAccountListV1`*(interfacename: AsyncIGameServersService, `key`: string): Future[string] {.async.} = 
  ## Gets a list of game server accounts with their logon tokens
  ## `key` : string — Access key
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAccountList/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `CreateAccountV1`*(interfacename: AsyncIGameServersService, `key`: string, `appid`: uint32, `memo`: string): Future[string] {.async.} = 
  ## Creates a persistent game server account
  ## `key` : string — Access key
  ## `appid` : uint32 — The app to use the account for
  ## `memo` : string — The memo to set on the new account
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/CreateAccount/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `SetMemoV1`*(interfacename: AsyncIGameServersService, `key`: string, `steamid`: uint64, `memo`: string): Future[string] {.async.} = 
  ## This method changes the memo associated with the game server account. Memos do not affect the account in any way. The memo shows up in the GetAccountList response and serves only as a reminder of what the account is used for.
  ## `key` : string — Access key
  ## `steamid` : uint64 — The SteamID of the game server to set the memo on
  ## `memo` : string — The memo to set on the new account
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetMemo/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `ResetLoginTokenV1`*(interfacename: AsyncIGameServersService, `key`: string, `steamid`: uint64): Future[string] {.async.} = 
  ## Generates a new login token for the specified game server
  ## `key` : string — Access key
  ## `steamid` : uint64 — The SteamID of the game server to reset the login token of
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ResetLoginToken/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `DeleteAccountV1`*(interfacename: AsyncIGameServersService, `key`: string, `steamid`: uint64): Future[string] {.async.} = 
  ## Deletes a persistent game server account
  ## `key` : string — Access key
  ## `steamid` : uint64 — The SteamID of the game server account to delete
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/DeleteAccount/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetAccountPublicInfoV1`*(interfacename: AsyncIGameServersService, `key`: string, `steamid`: uint64): Future[string] {.async.} = 
  ## Gets public information about a given game server account
  ## `key` : string — Access key
  ## `steamid` : uint64 — The SteamID of the game server to get info on
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAccountPublicInfo/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `QueryLoginTokenV1`*(interfacename: AsyncIGameServersService, `key`: string, `login_token`: string): Future[string] {.async.} = 
  ## Queries the status of the specified token, which must be owned by you
  ## `key` : string — Access key
  ## `login_token` : string — Login token to query
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryLoginToken/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerSteamIDsByIPV1`*(interfacename: AsyncIGameServersService, `key`: string, `server_ips`: string): Future[string] {.async.} = 
  ## Gets a list of server SteamIDs given a list of IPs
  ## `key` : string — Access key
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerSteamIDsByIP/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetServerIPsBySteamIDV1`*(interfacename: AsyncIGameServersService, `key`: string, `server_steamids`: uint64): Future[string] {.async.} = 
  ## Gets a list of server IP addresses given a list of SteamIDs
  ## `key` : string — Access key
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServerIPsBySteamID/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `QueryByFakeIPV1`*(interfacename: AsyncIGameServersService, `key`: string, `fake_ip`: uint32, `fake_port`: uint32, `app_id`: uint32, `query_type`: int): Future[string] {.async.} = 
  ## Perform a query on a specific server by FakeIP
  ## `key` : string — Access key
  ## `fake_ip` : uint32 — FakeIP of server to query.
  ## `fake_port` : uint32 — Fake port of server to query.
  ## `app_id` : uint32 — AppID to use.  Each AppID has its own FakeIP address.
  ## `query_type` : int — What type of query?
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryByFakeIP/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `IsPlayingSharedGameV1`*(interfacename: AsyncIPlayerService, `key`: string, `steamid`: uint64, `appid_playing`: uint32): Future[string] {.async.} = 
  ## Obsolete, partners should use ISteamUser.CheckAppOwnership
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## `appid_playing` : uint32 — The game player is currently playing
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/IsPlayingSharedGame/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `RecordOfflinePlaytimeV1`*(interfacename: AsyncIPlayerService, `steamid`: uint64, `ticket`: string, `play_sessions`: Message): Future[string] {.async.} = 
  ## Tracks playtime for a user when they are offline
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/RecordOfflinePlaytime/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetRecentlyPlayedGamesV1`*(interfacename: AsyncIPlayerService, `key`: string, `steamid`: uint64, `count`: uint32): Future[string] {.async.} = 
  ## Gets information about a player's recently played games
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## `count` : uint32 — The number of games to return (0/unset: all)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetRecentlyPlayedGames/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetOwnedGamesV1`*(interfacename: AsyncIPlayerService, `key`: string, `steamid`: uint64, `include_appinfo`: bool, `include_played_free_games`: bool, `appids_filter`: uint32, `include_free_sub`: bool, `skip_unvetted_apps`: bool): Future[string] {.async.} = 
  ## Return a list of games owned by the player
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## `include_appinfo` : bool — true if we want additional details (name, icon) about each game
  ## `include_played_free_games` : bool — Free games are excluded by default.  If this is set, free games the user has played will be returned.
  ## `appids_filter` : uint32 — if set, restricts result set to the passed in apps
  ## `include_free_sub` : bool — Some games are in the free sub, which are excluded by default.
  ## `skip_unvetted_apps` : bool — if set, skip unvetted store apps
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetOwnedGames/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetSteamLevelV1`*(interfacename: AsyncIPlayerService, `key`: string, `steamid`: uint64): Future[string] {.async.} = 
  ## Returns the Steam Level of a user
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamLevel/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetBadgesV1`*(interfacename: AsyncIPlayerService, `key`: string, `steamid`: uint64): Future[string] {.async.} = 
  ## Gets badges that are owned by a specific user
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetBadges/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetCommunityBadgeProgressV1`*(interfacename: AsyncIPlayerService, `key`: string, `steamid`: uint64, `badgeid`: int32): Future[string] {.async.} = 
  ## Gets all the quests needed to get the specified badge, and which are completed
  ## `key` : string — Access key
  ## `steamid` : uint64 — The player we're asking about
  ## `badgeid` : int32 — The badge we're asking about
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetCommunityBadgeProgress/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `PostGameDataFrameRTMPV1`*(interfacename: AsyncIBroadcastService, `appid`: uint32, `steamid`: uint64, `rtmp_token`: string, `frame_data`: string): Future[string] {.async.} = 
  ## Add a game meta data frame to broadcast from a client. Uses RTMP token for validation
  ## `appid` : uint32 — AppID of the game being broadcasted
  ## `steamid` : uint64 — Broadcasters SteamID
  ## `rtmp_token` : string — Valid RTMP token for the Broadcaster
  ## `frame_data` : string — game data frame expressing current state of game (string, zipped, whatever)
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/PostGameDataFrameRTMP/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `SetSteamCacheClientFiltersV1`*(interfacename: AsyncIContentServerConfigService, `key`: string, `cache_id`: uint32, `cache_key`: string, `change_notes`: string, `allowed_ip_blocks`: string): Future[string] {.async.} = 
  ## Update the client filters for a SteamCache node
  ## `key` : string — Access key
  ## `cache_id` : uint32 — Unique ID number
  ## `cache_key` : string — Valid current cache API key
  ## `change_notes` : string — Notes
  ## `allowed_ip_blocks` : string — comma-separated list of allowed IP address blocks in CIDR format - blank to clear unfilter
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamCacheClientFilters/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetSteamCacheNodeParamsV1`*(interfacename: AsyncIContentServerConfigService, `key`: string, `cache_id`: uint32, `cache_key`: string): Future[string] {.async.} = 
  ## Get the operational parameters for a SteamCache node (information the node uses to operate).
  ## `key` : string — Access key
  ## `cache_id` : uint32 — Unique ID number
  ## `cache_key` : string — Valid current cache API key
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetSteamCacheNodeParams/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `SetSteamCachePerformanceStatsV1`*(interfacename: AsyncIContentServerConfigService, `key`: string, `cache_id`: uint32, `cache_key`: string, `mbps_sent`: uint32, `mbps_recv`: uint32, `cpu_percent`: uint32, `cache_hit_percent`: uint32, `num_connected_ips`: uint32, `upstream_egress_utilization`: uint32): Future[string] {.async.} = 
  ## Update the performance/load stats for a SteamCache node
  ## `key` : string — Access key
  ## `cache_id` : uint32 — Unique ID number
  ## `cache_key` : string — Valid current cache API key
  ## `mbps_sent` : uint32 — Outgoing network traffic in Mbps
  ## `mbps_recv` : uint32 — Incoming network traffic in Mbps
  ## `cpu_percent` : uint32 — Percent CPU load
  ## `cache_hit_percent` : uint32 — Percent cache hits
  ## `num_connected_ips` : uint32 — Number of unique connected IP addresses
  ## `upstream_egress_utilization` : uint32 — What is the percent utilization of the busiest datacenter egress link?
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SetSteamCachePerformanceStats/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetServersForSteamPipeV1`*(interfacename: AsyncIContentServerDirectoryService, `cell_id`: uint32, `max_servers`: uint32, `ip_override`: string, `launcher_type`: int32, `ipv6_public`: string): Future[string] {.async.} = 
  ## `cell_id` : uint32 — client Cell ID
  ## `max_servers` : uint32 — max servers in response list
  ## `ip_override` : string — client IP address
  ## `launcher_type` : int32 — launcher type
  ## `ipv6_public` : string — client public ipv6 address if it knows it
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetServersForSteamPipe/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetClientUpdateHostsV1`*(interfacename: AsyncIContentServerDirectoryService, `cached_signature`: string): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetClientUpdateHosts/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetDepotPatchInfoV1`*(interfacename: AsyncIContentServerDirectoryService, `appid`: uint32, `depotid`: uint32, `source_manifestid`: uint64, `target_manifestid`: uint64): Future[string] {.async.} = 
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetDepotPatchInfo/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetUserVoteSummaryV1`*(interfacename: AsyncIPublishedFileService, `publishedfileids`: uint64): Future[string] {.async.} = 
  ## Get user vote summary
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserVoteSummary/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `QueryFilesV1`*(interfacename: AsyncIPublishedFileService, `key`: string, `query_type`: uint32, `page`: uint32, `cursor`: string, `numperpage`: uint32, `creator_appid`: uint32, `appid`: uint32, `requiredtags`: string, `excludedtags`: string, `match_all_tags`: bool, `required_flags`: string, `omitted_flags`: string, `search_text`: string, `filetype`: uint32, `child_publishedfileid`: uint64, `days`: uint32, `include_recent_votes_only`: bool, `cache_max_age_seconds`: uint32, `language`: int32, `required_kv_tags`: Message, `taggroups`: Message, `date_range_created`: Message, `date_range_updated`: Message, `totalonly`: bool, `ids_only`: bool, `return_vote_data`: bool, `return_tags`: bool, `return_kv_tags`: bool, `return_previews`: bool, `return_children`: bool, `return_short_description`: bool, `return_for_sale_data`: bool, `return_metadata`: bool, `return_playtime_stats`: uint32, `return_details`: bool, `strip_description_bbcode`: bool, `desired_revision`: int, `return_reactions`: bool): Future[string] {.async.} = 
  ## Performs a search query for published files
  ## `key` : string — Access key
  ## `query_type` : uint32 — enumeration EPublishedFileQueryType in clientenums.h
  ## `page` : uint32 — Current page
  ## `cursor` : string — Cursor to paginate through the results (set to '*' for the first request).  Prefer this over using the page parameter, as it will allow you to do deep pagination.  When used, the page parameter will be ignored.
  ## `numperpage` : uint32 — (Optional) The number of results, per page to return.
  ## `creator_appid` : uint32 — App that created the files
  ## `appid` : uint32 — App that consumes the files
  ## `requiredtags` : string — Tags to match on. See match_all_tags parameter below
  ## `excludedtags` : string — (Optional) Tags that must NOT be present on a published file to satisfy the query.
  ## `match_all_tags` : bool — If true, then items must have all the tags specified, otherwise they must have at least one of the tags.
  ## `required_flags` : string — Required flags that must be set on any returned items
  ## `omitted_flags` : string — Flags that must not be set on any returned items
  ## `search_text` : string — Text to match in the item's title or description
  ## `filetype` : uint32 — EPublishedFileInfoMatchingFileType
  ## `child_publishedfileid` : uint64 — Find all items that reference the given item.
  ## `days` : uint32 — If query_type is k_PublishedFileQueryType_RankedByTrend, then this is the number of days to get votes for [1,7].
  ## `include_recent_votes_only` : bool — If query_type is k_PublishedFileQueryType_RankedByTrend, then limit result set just to items that have votes within the day range given
  ## `cache_max_age_seconds` : uint32 — Allow stale data to be returned for the specified number of seconds.
  ## `language` : int32 — Language to search in and also what gets returned. Defaults to English.
  ## `required_kv_tags` : Message — Required key-value tags to match on.
  ## `taggroups` : Message — (Optional) At least one of the tags must be present on a published file to satisfy the query.
  ## `date_range_created` : Message — (Optional) Filter to items created within this range.
  ## `date_range_updated` : Message — (Optional) Filter to items updated within this range.
  ## `totalonly` : bool — (Optional) If true, only return the total number of files that satisfy this query.
  ## `ids_only` : bool — (Optional) If true, only return the published file ids of files that satisfy this query.
  ## `return_vote_data` : bool — Return vote data
  ## `return_tags` : bool — Return tags in the file details
  ## `return_kv_tags` : bool — Return key-value tags in the file details
  ## `return_previews` : bool — Return preview image and video details in the file details
  ## `return_children` : bool — Return child item ids in the file details
  ## `return_short_description` : bool — Populate the short_description field instead of file_description
  ## `return_for_sale_data` : bool — Return pricing information, if applicable
  ## `return_metadata` : bool — Populate the metadata
  ## `return_playtime_stats` : uint32 — Return playtime stats for the specified number of days before today.
  ## `return_details` : bool — By default, if none of the other 'return_*' fields are set, only some voting details are returned. Set this to true to return the default set of details.
  ## `strip_description_bbcode` : bool — Strips BBCode from descriptions.
  ## `desired_revision` : int — Return the data for the specified revision.
  ## `return_reactions` : bool — If true, then reactions to items will be returned.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/QueryFiles/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetDetailsV1`*(interfacename: AsyncIPublishedFileService, `key`: string, `publishedfileids`: uint64, `includetags`: bool, `includeadditionalpreviews`: bool, `includechildren`: bool, `includekvtags`: bool, `includevotes`: bool, `short_description`: bool, `includeforsaledata`: bool, `includemetadata`: bool, `language`: int32, `return_playtime_stats`: uint32, `appid`: uint32, `strip_description_bbcode`: bool, `desired_revision`: int, `includereactions`: bool): Future[string] {.async.} = 
  ## Retrieves information about a set of published files.
  ## `key` : string — Access key
  ## `publishedfileids` : uint64 — Set of published file Ids to retrieve details for.
  ## `includetags` : bool — If true, return tag information in the returned details.
  ## `includeadditionalpreviews` : bool — If true, return preview information in the returned details.
  ## `includechildren` : bool — If true, return children in the returned details.
  ## `includekvtags` : bool — If true, return key value tags in the returned details.
  ## `includevotes` : bool — If true, return vote data in the returned details.
  ## `short_description` : bool — If true, return a short description instead of the full description.
  ## `includeforsaledata` : bool — If true, return pricing data, if applicable.
  ## `includemetadata` : bool — If true, populate the metadata field.
  ## `language` : int32 — Specifies the localized text to return. Defaults to English.
  ## `return_playtime_stats` : uint32 — Return playtime stats for the specified number of days before today.
  ## `strip_description_bbcode` : bool — Strips BBCode from descriptions.
  ## `desired_revision` : int — Return the data for the specified revision.
  ## `includereactions` : bool — If true, then reactions to items will be returned.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetDetails/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetUserFilesV1`*(interfacename: AsyncIPublishedFileService, `key`: string, `steamid`: uint64, `appid`: uint32, `page`: uint32, `numperpage`: uint32, `type`: string, `sortmethod`: string, `privacy`: uint32, `requiredtags`: string, `excludedtags`: string, `required_kv_tags`: Message, `filetype`: uint32, `creator_appid`: uint32, `match_cloud_filename`: string, `cache_max_age_seconds`: uint32, `language`: int32, `taggroups`: Message, `totalonly`: bool, `ids_only`: bool, `return_vote_data`: bool, `return_tags`: bool, `return_kv_tags`: bool, `return_previews`: bool, `return_children`: bool, `return_short_description`: bool, `return_for_sale_data`: bool, `return_metadata`: bool, `return_playtime_stats`: uint32, `strip_description_bbcode`: bool, `return_reactions`: bool, `startindex_override`: uint32, `desired_revision`: int): Future[string] {.async.} = 
  ## Retrieves files published by a user.
  ## `key` : string — Access key
  ## `steamid` : uint64 — Steam ID of the user whose files are being requested.
  ## `appid` : uint32 — App Id of the app that the files were published to.
  ## `page` : uint32 — (Optional) Starting page for results.
  ## `numperpage` : uint32 — (Optional) The number of results, per page to return.
  ## `type` : string — (Optional) Type of files to be returned.
  ## `sortmethod` : string — (Optional) Sorting method to use on returned values.
  ## `privacy` : uint32 — (optional) Filter by privacy settings.
  ## `requiredtags` : string — (Optional) Tags that must be present on a published file to satisfy the query.
  ## `excludedtags` : string — (Optional) Tags that must NOT be present on a published file to satisfy the query.
  ## `required_kv_tags` : Message — Required key-value tags to match on.
  ## `filetype` : uint32 — (Optional) File type to match files to.
  ## `creator_appid` : uint32 — App Id of the app that published the files, only matched if specified.
  ## `match_cloud_filename` : string — Match this cloud filename if specified.
  ## `cache_max_age_seconds` : uint32 — Allow stale data to be returned for the specified number of seconds.
  ## `language` : int32 — Specifies the localized text to return. Defaults to English.
  ## `taggroups` : Message — (Optional) At least one of the tags must be present on a published file to satisfy the query.
  ## `totalonly` : bool — (Optional) If true, only return the total number of files that satisfy this query.
  ## `ids_only` : bool — (Optional) If true, only return the published file ids of files that satisfy this query.
  ## `return_vote_data` : bool — Return vote data
  ## `return_tags` : bool — Return tags in the file details
  ## `return_kv_tags` : bool — Return key-value tags in the file details
  ## `return_previews` : bool — Return preview image and video details in the file details
  ## `return_children` : bool — Return child item ids in the file details
  ## `return_short_description` : bool — Populate the short_description field instead of file_description
  ## `return_for_sale_data` : bool — Return pricing information, if applicable
  ## `return_metadata` : bool — Populate the metadata field
  ## `return_playtime_stats` : uint32 — Return playtime stats for the specified number of days before today.
  ## `strip_description_bbcode` : bool — Strips BBCode from descriptions.
  ## `return_reactions` : bool — If true, then reactions to items will be returned.
  ## `startindex_override` : uint32 — Backwards compatible for the client.
  ## `desired_revision` : int — Return the data for the specified revision.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetUserFiles/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeHistoryV1`*(interfacename: AsyncIEconService, `key`: string, `max_trades`: uint32, `start_after_time`: uint32, `start_after_tradeid`: uint64, `navigating_back`: bool, `get_descriptions`: bool, `language`: string, `include_failed`: bool, `include_total`: bool): Future[string] {.async.} = 
  ## Gets a history of trades
  ## `key` : string — Access key
  ## `max_trades` : uint32 — The number of trades to return information for
  ## `start_after_time` : uint32 — The time of the last trade shown on the previous page of results, or the time of the first trade if navigating back
  ## `start_after_tradeid` : uint64 — The tradeid shown on the previous page of results, or the ID of the first trade if navigating back
  ## `navigating_back` : bool — The user wants the previous page of results, so return the previous max_trades trades before the start time and ID
  ## `get_descriptions` : bool — If set, the item display data for the items included in the returned trades will also be returned
  ## `language` : string — The language to use when loading item display data
  ## `include_total` : bool — If set, the total number of trades the account has participated in will be included in the response
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeHistory/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeStatusV1`*(interfacename: AsyncIEconService, `key`: string, `tradeid`: uint64, `get_descriptions`: bool, `language`: string): Future[string] {.async.} = 
  ## Gets status for a specific trade
  ## `key` : string — Access key
  ## `get_descriptions` : bool — If set, the item display data for the items included in the returned trades will also be returned
  ## `language` : string — The language to use when loading item display data
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeStatus/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeOffersV1`*(interfacename: AsyncIEconService, `key`: string, `get_sent_offers`: bool, `get_received_offers`: bool, `get_descriptions`: bool, `language`: string, `active_only`: bool, `historical_only`: bool, `time_historical_cutoff`: uint32, `cursor`: uint32): Future[string] {.async.} = 
  ## Get a list of sent or received trade offers
  ## `key` : string — Access key
  ## `get_sent_offers` : bool — Request the list of sent offers.
  ## `get_received_offers` : bool — Request the list of received offers.
  ## `get_descriptions` : bool — If set, the item display data for the items included in the returned trade offers will also be returned. If one or more descriptions can't be retrieved, then your request will fail.
  ## `language` : string — The language to use when loading item display data.
  ## `active_only` : bool — Indicates we should only return offers which are still active, or offers that have changed in state since the time_historical_cutoff
  ## `historical_only` : bool — Indicates we should only return offers which are not active.
  ## `time_historical_cutoff` : uint32 — When active_only is set, offers updated since this time will also be returned
  ## `cursor` : uint32 — Cursor aka start index
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffers/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeOfferV1`*(interfacename: AsyncIEconService, `key`: string, `tradeofferid`: uint64, `language`: string, `get_descriptions`: bool): Future[string] {.async.} = 
  ## Gets a specific trade offer
  ## `key` : string — Access key
  ## `get_descriptions` : bool — If set, the item display data for the items included in the returned trade offers will also be returned. If one or more descriptions can't be retrieved, then your request will fail.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffer/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeOffersSummaryV1`*(interfacename: AsyncIEconService, `key`: string, `time_last_visit`: uint32): Future[string] {.async.} = 
  ## Get counts of pending and new trade offers
  ## `key` : string — Access key
  ## `time_last_visit` : uint32 — The time the user last visited.  If not passed, will use the time the user last visited the trade offer page.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeOffersSummary/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetTradeHoldDurationsV1`*(interfacename: AsyncIEconService, `key`: string, `steamid_target`: uint64, `trade_offer_access_token`: string): Future[string] {.async.} = 
  ## Returns the estimated hold duration and end date that a trade with a user would have
  ## `key` : string — Access key
  ## `steamid_target` : uint64 — User you are trading with
  ## `trade_offer_access_token` : string — A special token that allows for trade offers from non-friends.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetTradeHoldDurations/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `UserCreateSessionV1`*(interfacename: AsyncIGameNotificationsService, `appid`: uint32, `context`: uint64, `title`: Message, `users`: Message, `steamid`: uint64): Future[string] {.async.} = 
  ## Creates an async game session
  ## `appid` : uint32 — The appid to create the session for.
  ## `context` : uint64 — Game-specified context value the game can used to associate the session with some object on their backend.
  ## `title` : Message — The title of the session to be displayed within each user's list of sessions.
  ## `users` : Message — The initial state of all users in the session.
  ## `steamid` : uint64 — (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session and all users being added to the session must be friends with the user.
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserCreateSession/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `UserUpdateSessionV1`*(interfacename: AsyncIGameNotificationsService, `sessionid`: uint64, `appid`: uint32, `title`: Message, `users`: Message, `steamid`: uint64): Future[string] {.async.} = 
  ## Updates an async game session
  ## `sessionid` : uint64 — The sessionid to update.
  ## `appid` : uint32 — The appid of the session to update.
  ## `title` : Message — (Optional) The new title of the session.  If not specified, the title will not be changed.
  ## `users` : Message — (Optional) A list of users whose state will be updated to reflect the given state. If the users are not already in the session, they will be added to it.
  ## `steamid` : uint64 — (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session and all users being added to the session must be friends with the user.
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserUpdateSession/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `UserDeleteSessionV1`*(interfacename: AsyncIGameNotificationsService, `sessionid`: uint64, `appid`: uint32, `steamid`: uint64): Future[string] {.async.} = 
  ## Deletes an async game session
  ## `sessionid` : uint64 — The sessionid to delete.
  ## `appid` : uint32 — The appid of the session to delete.
  ## `steamid` : uint64 — (Optional) steamid to make the request on behalf of -- if specified, the user must be in the session.
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/UserDeleteSession/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `SplitItemStackV1`*(interfacename: AsyncIInventoryService, `key`: string, `appid`: uint32, `itemid`: uint64, `quantity`: uint32, `steamid`: uint64): Future[string] {.async.} = 
  ## Split an item stack into two stacks
  ## `key` : string — Access key
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/SplitItemStack/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `CombineItemStacksV1`*(interfacename: AsyncIInventoryService, `key`: string, `appid`: uint32, `fromitemid`: uint64, `destitemid`: uint64, `quantity`: uint32, `steamid`: uint64): Future[string] {.async.} = 
  ## Combine two stacks of items
  ## `key` : string — Access key
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/CombineItemStacks/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 

proc `GetPriceSheetV1`*(interfacename: AsyncIInventoryService, `key`: string, `ecurrency`: int32, `currency_code`: string): Future[string] {.async.} = 
  ## Get the Inventory Service price sheet
  ## `key` : string — Access key
  ## `currency_code` : string — Standard short code of the requested currency (preferred)
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetPriceSheet/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `GetAppListV1`*(interfacename: AsyncIStoreService, `key`: string, `if_modified_since`: uint32, `have_description_language`: string, `include_games`: bool, `include_dlc`: bool, `include_software`: bool, `include_videos`: bool, `include_hardware`: bool, `last_appid`: uint32, `max_results`: uint32): Future[string] {.async.} = 
  ## Gets a list of apps available on the Steam Store.
  ## `key` : string — Access key
  ## `if_modified_since` : uint32 — Return only items that have been modified since this date.
  ## `have_description_language` : string — Return only items that have a description in this language.
  ## `include_games` : bool — Include games (defaults to enabled)
  ## `include_dlc` : bool — Include DLC
  ## `include_software` : bool — Include software items
  ## `include_videos` : bool — Include videos and series
  ## `include_hardware` : bool — Include hardware
  ## `last_appid` : uint32 — For continuations, this is the last appid returned from the previous call.
  ## `max_results` : uint32 — Number of results to return at a time.  Default 10k, max 50k.
  ## HTTP METHOD GET
  let url = WEBAPI_BASE_URL & interfacename.name & "/GetAppList/v1/"
  var client = newAsyncHttpClient()
  return await client.getContent(url) 

proc `ReportCheatDataV1`*(interfacename: AsyncICheatReportingService, `key`: string, `steamid`: uint64, `appid`: uint32, `pathandfilename`: string, `webcheaturl`: string, `time_now`: uint64, `time_started`: uint64, `time_stopped`: uint64, `cheatname`: string, `game_process_id`: uint32, `cheat_process_id`: uint32, `cheat_param_1`: uint64, `cheat_param_2`: uint64, `cheat_data_dump`: string): Future[string] {.async.} = 
  ## Reports cheat data. Only use on test account that is running the game but not in a multiplayer session.
  ## `key` : string — Access key
  ## `steamid` : uint64 — steamid of the user running and reporting the cheat.
  ## `appid` : uint32 — The appid.
  ## `pathandfilename` : string — path and file name of the cheat executable.
  ## `webcheaturl` : string — web url where the cheat was found and downloaded.
  ## `time_now` : uint64 — local system time now.
  ## `time_started` : uint64 — local system time when cheat process started. ( 0 if not yet run )
  ## `time_stopped` : uint64 — local system time when cheat process stopped. ( 0 if still running )
  ## `cheatname` : string — descriptive name for the cheat.
  ## `game_process_id` : uint32 — process ID of the running game.
  ## `cheat_process_id` : uint32 — process ID of the cheat process that ran
  ## `cheat_param_1` : uint64 — cheat param 1
  ## `cheat_param_2` : uint64 — cheat param 2
  ## `cheat_data_dump` : string — data collection in json format
  ## HTTP METHOD POST
  let url = WEBAPI_BASE_URL & interfacename.name & "/ReportCheatData/v1/"
  var client = newAsyncHttpClient()
  return await client.postContent(url, multipart=nil) 