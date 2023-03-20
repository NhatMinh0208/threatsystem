local plyMeta = FindMetaTable("Player")

function plyMeta:getThreatLevel()
    return self:getDarkRPVar("threatLevel")
end

function plyMeta:getSusLevel()
    return self:getDarkRPVar("susLevel")
end

function plyMeta:isThreat()
    local level = self:getDarkRPVar("threatLevel")
    if level and level~=0 then return true else return false end
end

--[[---------------------------------------------------------------------------
DarkRPVars
---------------------------------------------------------------------------]]
DarkRP.registerDarkRPVar("threatLevel", fn.Curry(fn.Flip(net.WriteInt), 2)(32), fn.Partial(net.ReadInt, 32))
DarkRP.registerDarkRPVar("susLevel", net.WriteFloat, net.ReadFloat)

--[[---------------------------------------------------------------------------
Debug chat commands
---------------------------------------------------------------------------]]
DarkRP.declareChatCommand{
    command = "setthreatlevel",
    description = "Set your threat level",
    delay = 1
}

DarkRP.declareChatCommand{
    command = "setsuslevel",
    description = "Set your sus level",
    delay = 1
}
