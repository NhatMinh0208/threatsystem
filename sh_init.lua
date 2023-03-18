local plyMeta = FindMetaTable("Player")

function plyMeta:getThreatLevel()
    return self:getDarkRPVar("threatLevel")
end


--[[---------------------------------------------------------------------------
DarkRPVars
---------------------------------------------------------------------------]]
DarkRP.registerDarkRPVar("threatLevel", fn.Curry(fn.Flip(net.WriteInt), 2)(32), fn.Partial(net.ReadInt, 32))

--[[---------------------------------------------------------------------------
Debug chat commands
---------------------------------------------------------------------------]]
DarkRP.declareChatCommand{
    command = "setthreatlevel",
    description = "Set your threat level",
    delay = 1
}

DarkRP.declareChatCommand{
    command = "getthreatlevel",
    description = "Set your threat level",
    delay = 1
}
