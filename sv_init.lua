local plyMeta = FindMetaTable("Player")

function plyMeta:setWantedLevel(level)
    self:setDarkRPVar("wantedLevel", level)
    DarkRP.storeWantedLevel(self, level)
end

--[[---------------------------------------------------------------------------
Debug chat commands
---------------------------------------------------------------------------]]
DarkRP.defineChatCommand("setwantedlevel", function(ply, args)
    local level = DarkRP.toInt(args) or 0
    ply:setWantedLevel(level)
    level = ply:getWantedLevel()

    DarkRP.notify(ply, 2, 5, DarkRP.getPhrase("wanted_level_set", level))

    return ""
end)

DarkRP.defineChatCommand("getwantedlevel", function(ply, args)
    level = ply:getWantedLevel()

    DarkRP.notify(ply, 2, 5, DarkRP.getPhrase("wanted_level_get", level))

    return ""
end)
