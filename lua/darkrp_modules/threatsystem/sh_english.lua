--[[-----------------------------------------------------------------------
Additional translations for Threat System (en)
---------------------------------------------------------------------------
Instructions:
Add the translations below to the darkrp_language/english file.
---------------------------------------------------------------------------]]

local threatsystem_en = {
    reset_threatlevel = "%s has reset all players' threat level!",

    must_be_threat_for_arrest = "The player must be a threat in order to be able to arrest them.",
    must_be_wanted_or_threat = "The player must be wanted or a threat in order to be able to arrest them.",
    
    threat_level_set = "Your threat level has been set to: %s",
    sus_level_set = "Your sus level has been set to: %s",
    threat_level_increase = "Your threat level has been increased to: %s",
    threat_level_decrease = "Your threat level has been decreased to: %s",
    
    jail_threatauto = "You have disconnected while being a threat! You are now jailed for %d seconds",

    threatlevel = "Threat level: %s",
    suslevel = "Sus level: %s"
}

DarkRP.addLanguage("en", threatsystem_en)

