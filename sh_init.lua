local plyMeta = FindMetaTable("Player")

function plyMeta:getWantedLevel()
    return self:getDarkRPVar("wantedLevel")
end


--[[---------------------------------------------------------------------------
DarkRPVars
---------------------------------------------------------------------------]]
DarkRP.registerDarkRPVar("wantedLevel", fn.Curry(fn.Flip(net.WriteInt), 2)(32), fn.Partial(net.ReadInt, 32))

--[[---------------------------------------------------------------------------
Debug chat commands
---------------------------------------------------------------------------]]
DarkRP.declareChatCommand{
    command = "setwantedlevel",
    description = "Set your wanted level",
    delay = 1
}

DarkRP.declareChatCommand{
    command = "getwantedlevel",
    description = "Set your wanted level",
    delay = 1
}
