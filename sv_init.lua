local plyMeta = FindMetaTable("Player")

function plyMeta:setThreatLevel(level)
    self:setDarkRPVar("threatLevel", level)
    DarkRP.storeThreatLevel(self, level)
end

--[[---------------------------------------------------------------------------
Debug chat commands
---------------------------------------------------------------------------]]
DarkRP.defineChatCommand("setthreatlevel", function(ply, args)
    local level = DarkRP.toInt(args) or 0
    ply:setThreatLevel(level)
    level = ply:getThreatLevel()

    DarkRP.notify(ply, 2, 5, DarkRP.getPhrase("threat_level_set", level))

    return ""
end)

DarkRP.defineChatCommand("getthreatlevel", function(ply, args)
    level = ply:getThreatLevel()

    DarkRP.notify(ply, 2, 5, DarkRP.getPhrase("threat_level_get", level))

    return ""
end)
