local plyMeta = FindMetaTable("Player")

function plyMeta:setThreatLevel(level)
    if (level == nil) then return end
    if ((level >= 0) and (level <= GAMEMODE.Config.maxthreatlevel)) then
        self:setDarkRPVar("threatLevel", level)
        DarkRP.storeThreatLevel(self, level)
    end
    
    
        -- implement threat level decay

    if (level > 0) then
        if (GAMEMODE.Config.enablesus) then
            timer.Remove(self:SteamID64() .. "threatdecay")
            timer.Create(self:SteamID64() .. "threatdecay", self:getSusLevel(), 1, function()
                self:setThreatLevel(level - 1)
                DarkRP.notify(self, 2, 5, DarkRP.getPhrase("threat_level_decrease", level - 1))
            end)
        else
            timer.Remove(self:SteamID64() .. "threatdecay")
            timer.Create(self:SteamID64() .. "threatdecay", GAMEMODE.Config.threatdecaytime, 1, function()
                self:setThreatLevel(level - 1)
                DarkRP.notify(self, 2, 5, DarkRP.getPhrase("threat_level_decrease", level - 1))
            end)
        end
    end

end

function plyMeta:setSusLevel(level) 
    
    FAdmin.Log(level)

    if (level == nil) then return end
    if (level >= GAMEMODE.Config.defaultsuslevel) then
        self:setDarkRPVar("susLevel", level)
        DarkRP.storeSusLevel(self, level)
    end
    
    if (level > GAMEMODE.Config.defaultsuslevel) then
        timer.Remove(self:SteamID64() .. "susdecay")
        timer.Create(self:SteamID64() .. "susdecay", 1, 1, function()
            self:setSusLevel(level - GAMEMODE.Config.susdecay)
        end)
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

DarkRP.defineChatCommand("setsuslevel", function(ply, args)
    local level = tonumber(args) or 0
    ply:setSusLevel(level)
    level = ply:getSusLevel()

    DarkRP.notify(ply, 2, 5, DarkRP.getPhrase("sus_level_set", level))

    return ""
end)
