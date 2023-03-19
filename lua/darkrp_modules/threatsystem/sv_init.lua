local plyMeta = FindMetaTable("Player")

function plyMeta:setThreatLevel(level)
    if (level == nil) then return end
    if ((level >= 0) and (level <= GAMEMODE.Config.maxthreatlevel)) then
        self:setDarkRPVar("threatLevel", level)
        DarkRP.storeThreatLevel(self, level)
        -- implement threat level decay
        if (level > 0) then
            timer.Remove(self:SteamID64() .. "threatdecay")
            timer.Create(self:SteamID64() .. "threatdecay", GAMEMODE.Config.threatdecaytime, 1, function()
                self:setThreatLevel(level - 1)
                DarkRP.notify(self, 2, 5, DarkRP.getPhrase("threat_level_decrease", level - 1))
            end)
        end
    end
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
