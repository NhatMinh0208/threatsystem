--[[---------------------------------------------------------------------------
Threat System module
---------------------------------------------------------------------------]]
-- The default threat level.
GM.Config.defaultthreatlevel = 0
-- The maximum threat level.
GM.Config.maxthreatlevel = 5
-- Amount of time before a player's threat level decreases by 1 (in seconds).
GM.Config.threatdecaytime = 120

-- If true, the player must be a threat in order to arrest them.
GM.Config.needthreatforarrest = false
-- If true, the player must be either wanted or a threat in order to arrest them. Overrides both needwantedforarrest and needthreatforarrest.
GM.Config.needwantedorthreat = false

-- How much time (in seconds) should be added to jail time per threat level.
GM.Config.additionaljailtime = 10
-- If true, automatically jails the player if they log in while having a threat level.
GM.Config.jailthreatonlogin = true
-- If true, automatically jails the player if they are killed while having a threat level.
GM.Config.jailthreatondeath = true

-- Whether to display threat level on top of player or not.
GM.Config.showthreatlevel = true