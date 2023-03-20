--[[---------------------------------------------------------------------------
HUD ConVars
---------------------------------------------------------------------------]]
local ConVars = {}
local HUDWidth
local HUDHeight

local Color = Color
local CurTime = CurTime
local cvars = cvars
local DarkRP = DarkRP
local draw = draw
local GetConVar = GetConVar
local hook = hook
local IsValid = IsValid
local Lerp = Lerp
local localplayer
local math = math
local pairs = pairs
local ScrW, ScrH = ScrW, ScrH
local SortedPairs = SortedPairs
local string = string
local surface = surface
local table = table
local timer = timer
local tostring = tostring
local plyMeta = FindMetaTable("Player")

local colors = {}
colors.black = color_black
colors.blue = Color(0, 0, 255, 255)
colors.brightred = Color(200, 30, 30, 255)
colors.darkred = Color(0, 0, 70, 100)
colors.darkblack = Color(0, 0, 0, 200)
colors.gray1 = Color(0, 0, 0, 155)
colors.gray2 = Color(51, 58, 51,100)
colors.red = Color(255, 0, 0, 255)
colors.white = color_white
colors.white1 = Color(255, 255, 255, 200)

local function ReloadConVars()
    ConVars = {
        background = {0,0,0,100},
        Healthbackground = {0,0,0,200},
        Healthforeground = {140,0,0,180},
        HealthText = {255,255,255,200},
        Job1 = {0,0,150,200},
        Job2 = {0,0,0,255},
        salary1 = {0,150,0,200},
        salary2 = {0,0,0,255},
        tlevel1 = {150,0,0,200},
        tlevel2 = {0,0,0,255},
        sus1 = {150,0,150,200},
        sus2 = {0,0,0,255}
    }

    for name, Colour in pairs(ConVars) do
        ConVars[name] = {}
        for num, rgb in SortedPairs(Colour) do
            local CVar = GetConVar(name .. num) or CreateClientConVar(name .. num, rgb, true, false)
            table.insert(ConVars[name], CVar:GetInt())

            if not cvars.GetConVarCallbacks(name .. num, false) then
                cvars.AddChangeCallback(name .. num, function()
                    timer.Simple(0, ReloadConVars)
                end)
            end
        end
        ConVars[name] = Color(unpack(ConVars[name]))
    end


    HUDWidth =  (GetConVar("HudW") or CreateClientConVar("HudW", 240, true, false)):GetInt()
    HUDHeight = (GetConVar("HudH") or CreateClientConVar("HudH", 115, true, false)):GetInt()

    if not cvars.GetConVarCallbacks("HudW", false) and not cvars.GetConVarCallbacks("HudH", false) then
        cvars.AddChangeCallback("HudW", function() timer.Simple(0,ReloadConVars) end)
        cvars.AddChangeCallback("HudH", function() timer.Simple(0,ReloadConVars) end)
    end
end
ReloadConVars()

--[[---------------------------------------------------------------------------
Entity HUDPaint things
---------------------------------------------------------------------------]]
-- Draw a player's name, health and/or job above the head
-- This syntax allows for easy overriding
function newDrawPlayerInfo(self)
    -- print( "Hello world" )

    local pos = self:EyePos()

    pos.z = pos.z + 10 -- The position we want is a bit above the position of the eyes
    pos = pos:ToScreen()
    if not self:getDarkRPVar("wanted") then
        -- Move the text up a few pixels to compensate for the height of the text
        pos.y = pos.y - 50
    end

    if GAMEMODE.Config.showname then
        local nick, plyTeam = self:Nick(), self:Team()
        draw.DrawNonParsedText(nick, "DarkRPHUD2", pos.x + 1, pos.y + 1, colors.black, 1)
        draw.DrawNonParsedText(nick, "DarkRPHUD2", pos.x, pos.y, RPExtraTeams[plyTeam] and RPExtraTeams[plyTeam].color or team.GetColor(plyTeam) , 1)
    end

    if GAMEMODE.Config.showhealth then
        local health = DarkRP.getPhrase("health", math.max(0, self:Health()))
        draw.DrawNonParsedText(health, "DarkRPHUD2", pos.x + 1, pos.y + 21, colors.black, 1)
        draw.DrawNonParsedText(health, "DarkRPHUD2", pos.x, pos.y + 20, colors.white1, 1)
    end

    if GAMEMODE.Config.showjob then
        local teamname = self:getDarkRPVar("job") or team.GetName(self:Team())
        draw.DrawNonParsedText(teamname, "DarkRPHUD2", pos.x + 1, pos.y + 41, colors.black, 1)
        draw.DrawNonParsedText(teamname, "DarkRPHUD2", pos.x, pos.y + 40, colors.white1, 1)
    end

    if GAMEMODE.Config.showthreatlevel then
        local tlevel = self:getThreatLevel() or 0
        local tlevelstring = DarkRP.getPhrase("threatlevel", tostring(tlevel))
        if (tlevel == 0) then
            draw.DrawNonParsedText(tlevelstring, "DarkRPHUD2", pos.x + 1, pos.y + 61, colors.black, 1)
            draw.DrawNonParsedText(tlevelstring, "DarkRPHUD2", pos.x, pos.y + 60, colors.white1, 1)
        else
            draw.DrawNonParsedText(tlevelstring, "DarkRPHUD2", pos.x + 1, pos.y + 61, colors.gray1, 1)
            draw.DrawNonParsedText(tlevelstring, "DarkRPHUD2", pos.x, pos.y + 60, colors.red, 1)
        end
    end
    
    if GAMEMODE.Config.showsuslevel then
        local sus = self:getSusLevel() or 0
        local susstring = DarkRP.getPhrase("suslevel", tostring(sus))
        draw.DrawNonParsedText(susstring, "DarkRPHUD2", pos.x + 1, pos.y + 81, colors.black, 1)
        draw.DrawNonParsedText(susstring, "DarkRPHUD2", pos.x, pos.y + 80, colors.white1, 1)
        
    end

    if self:getDarkRPVar("HasGunlicense") then
        surface.SetMaterial(Page)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect(pos.x-16, pos.y + 100, 32, 32)
    end
end
plyMeta.drawPlayerInfo = newDrawPlayerInfo







local Scrw, Scrh, RelativeX, RelativeY

local function DrawThreatLevel()
    local threatLevel = localplayer:getThreatLevel() or 0
    threatLevelText = DarkRP.getPhrase("threatlevel", tostring(threatLevel))
    -- print(threatLevelText)
    draw.DrawNonParsedText(threatLevelText, "DarkRPHUD2", RelativeX + 5, RelativeY - HUDHeight + 6 - 85, ConVars.tlevel1, 0)
    draw.DrawNonParsedText(threatLevelText, "DarkRPHUD2", RelativeX + 4, RelativeY - HUDHeight + 5 - 85, ConVars.tlevel2, 0)
end


local function DrawSusLevel()
    local susLevel = localplayer:getSusLevel() or 0
    susLevelText = DarkRP.getPhrase("suslevel", tostring(susLevel))
    -- print(threatLevelText)
    draw.DrawNonParsedText(susLevelText, "DarkRPHUD2", RelativeX + 5, RelativeY - HUDHeight + 6 - 45, ConVars.sus1, 0)
    draw.DrawNonParsedText(susLevelText, "DarkRPHUD2", RelativeX + 4, RelativeY - HUDHeight + 5 - 45, ConVars.sus2, 0)
end

local function DrawThreatSystemHud(gamemodeTable)
    localplayer = localplayer or LocalPlayer()
    local shouldDraw = hook.Call("HUDShouldDraw", gamemodeTable, "DarkRP_HUD")
    if shouldDraw == false then return end

    Scrw, Scrh = ScrW(), ScrH()
    RelativeX, RelativeY = 0, Scrh

    shouldDraw = hook.Call("HUDShouldDraw", gamemodeTable, "DarkRP_LocalPlayerHUD")
    shouldDraw = shouldDraw ~= false
    if shouldDraw then
        --Background
        draw.RoundedBox(6, 0, Scrh - HUDHeight - 85, HUDWidth, 80, ConVars.background)
        if GAMEMODE.Config.showthreatlevel then
            DrawThreatLevel()
        end
        if GAMEMODE.Config.showsuslevel then
            DrawSusLevel()
        end
    end
end

hook.Add( "HUDPaint", "threatsystem_hud", DrawThreatSystemHud)