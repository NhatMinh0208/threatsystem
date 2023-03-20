hook.Add( "PlayerDeath", "threatHandler", function( victim, inflictor, attacker )
    if victim ~= attacker then
        if victim:isThreat() and GAMEMODE.Config.jailthreatondeath then
            local time = (GAMEMODE.Config.jailtimer or 120) + (GAMEMODE.Config.additionaljailtime or 120) * (victim:getThreatLevel() or 0)
            victim:arrest(time)
            DarkRP.notify(victim, 1, 5, DarkRP.getPhrase("youre_arrested_threat"))
        elseif not victim:isThreat() then
            local sus = attacker:getSusLevel()
            attacker:setSusLevel(sus + GAMEMODE.Config.susonkill)
            local level = attacker:getThreatLevel()
            attacker:setThreatLevel(level + 1)
            level = attacker:getThreatLevel()
            DarkRP.notify(attacker, 1, 5, DarkRP.getPhrase("threat_level_increase", level))
        end
    end
end )