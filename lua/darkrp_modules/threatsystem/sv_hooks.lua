hook.Add( "PlayerDeath", "threatHandler", function( victim, inflictor, attacker )
    if victim ~= attacker then
        if victim:isThreat() and GAMEMODE.Config.jailthreatondeath then
            local time = (GAMEMODE.Config.jailtimer or 120) + (GAMEMODE.Config.additionaljailtime or 120) * (victim:getThreatLevel() or 0)
            victim:arrest(time)
            DarkRP.notify(victim, 1, 5, DarkRP.getPhrase("youre_arrested_threat"))
        elseif not victim:isThreat() then
            local sus = attacker:getSusLevel()
            attacker:setSusLevel(sus + GAMEMODE.Config.susonkill)
            attacker:addThreatLevel(1)
        end
    end
end )

hook.Add("onLockpickCompleted", "threatHandler", function(ply, success, ent)
    if (success) then
        ply:addThreatLevel(1)
    end
end )

hook.Add("onThreatLevelChange", "firePolice", function(ply, previous, current)
    if ((previous < current) and (ply:isCP() or ply:isChief())) then
        for k,v in pairs(RPExtraTeams[TEAM_POLICE].weapons) do
            -- print(v)
            ply:StripWeapon(v)
        end
        for k,v in pairs(RPExtraTeams[TEAM_CHIEF].weapons) do
            -- print(v)
            ply:StripWeapon(v)
        end
        ply:changeTeam(GAMEMODE.DefaultTeam, true, false)
    end
end )