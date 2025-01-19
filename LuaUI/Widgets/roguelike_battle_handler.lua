--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
	return {
		name      = "Roguelike Battle Handler",
		desc      = "Reports outcome of roguelike battles.",
		author    = "Niarteloc",
		date      = "18 Jan 2025",
		license   = "GNU GPL, v2 or later",
		layer     = 1500, -- Put the end screen below chili
		enabled   = true,
		alwaysStart = true,
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local roguelikeBattleID = Spring.GetModOptions().roguelikebattleid
local missionDifficulty = tonumber(Spring.GetModOptions().planetmissiondifficulty) or 2
if not roguelikeBattleID then
	return
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Variables/config


local Chili

local WIN_MESSAGE = "Roguelike_BattleWon"
local LOST_MESSAGE = "Roguelike_BattleLost"
local RESIGN_MESSAGE = "Roguelike_BattleResign"

local missionWon, missionEndFrame, missionEndTime, missionResultSent

-- wait this many frames after victory to make sure your commander doesn't die.
local VICTORY_SUSTAIN_FRAMES = 50
local ADD_GLOBAL_COMMAND_BUTTON = false
local SCREEN_EDGE = 8

local BUTTON_SIZE = 25

local spGetDescription = Spring.Utilities.GetDescription
local spGetHumanName = Spring.Utilities.GetHumanName
local spGetModKeyState = Spring.GetModKeyState
local spGetMouseState = Spring.GetMouseState
local spGetUnitDefID = Spring.GetUnitDefID

local max, min = math.max, math.min

local glColor               = gl.Color
local glTexture             = gl.Texture
local glPopMatrix           = gl.PopMatrix
local glPushMatrix          = gl.PushMatrix
local glTranslate           = gl.Translate
local glText                = gl.Text
local glBeginEnd            = gl.BeginEnd
local glTexRect             = gl.TexRect
local glLoadFont            = gl.LoadFont
local glDeleteFont          = gl.DeleteFont
local glRect                = gl.Rect
local glLineWidth           = gl.LineWidth
local glDepthTest           = gl.DepthTest

local osClock               = os.clock

local briefingWindow

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Endgame screen

local boxWidth = 240
local boxHeight = 60
local autoFadeTime = 1.9
local continueFadeInTime = 1.3
local wndBorderSize = 4
local fontSizeHeadline = 84
local fontSizeAddon = 20
local fontPath = "LuaUI/Fonts/MicrogrammaDBold.ttf"
local minTransparency_autoFade = 0.1
local maxTransparency_autoFade = 0.7

local gameNotStarted = true
local wantPause = false
local firstUpdates = 0

local screenx, screeny, myFont
local screenCenterX, screenCenterY, wndX1, wndY1, wndX2, wndY2
local victoryTextX, defeatTextX, defeatTextX, lowerTextX
local textY, lineOffset, yCenter, xCut, mouseOver

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Utilities

VFS.Include("LuaRules/Utilities/tablefunctions.lua")

local function SetWindowSkin(targetPanel, className)
	local currentSkin = Chili.theme.skin.general.skinName
	local skin = Chili.SkinHandler.GetSkin(currentSkin)
	local newClass = skin.panel
	if skin[className] then
		newClass = skin[className]
	end

	targetPanel.tiles = newClass.tiles
	targetPanel.TileImage = newClass.TileImage
	--targetPanel.backgroundColor = newClass.backgroundColor
	if newClass.padding then
		targetPanel.padding = newClass.padding
		targetPanel:UpdateClientArea()
	end
	targetPanel:Invalidate()
end

local function TakeMouseOffEdge()
	-- Take off the edge to prevent pregame scroll and commander loss.
	-- This usually doesn't matter because in other game modes the player starts zoomed out.
	local mx, my, lmb, mmb, rmb, outsideSpring = Spring.GetMouseState()
	if outsideSpring then
		return
	end

	local screenWidth, screenHeight = Spring.GetViewGeometry()
	local changed = false

	if mx < SCREEN_EDGE then
		mx = SCREEN_EDGE
		changed = true
	elseif mx > screenWidth - SCREEN_EDGE then
		mx = screenWidth - SCREEN_EDGE
		changed = true
	end

	if my < SCREEN_EDGE then
		my = SCREEN_EDGE
		changed = true
	elseif my > screenHeight - SCREEN_EDGE then
		my = screenHeight - SCREEN_EDGE
		changed = true
	end

	if changed then
		Spring.WarpMouse(mx, my)
	end
	return changed
end

local function GetGameRulesHax(key)
	--return Spring.GetGameRulesParam(key)
	return Spring.GetTeamRulesParam(0, key)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Victory/Defeat

local function GetTimeString()
	local frames = GetGameRulesHax("MissionGameOver_frames") or select(1, Spring.GetGameFrame()) or 0
	return frames
end

local function GetLossesString()
	local losses = GetGameRulesHax("MissionGameOver_losses") or 10000000
	return losses
end

local function SendVictoryToLuaMenu(gameID)
	local luaMenu = Spring.GetMenuName and Spring.SendLuaMenuMsg and Spring.GetMenuName()
	if luaMenu then
		Spring.SendLuaMenuMsg(WIN_MESSAGE .. " " .. gameID .. " " .. GetTimeString() .. " " .. (missionDifficulty or "0") .. " " .. GetLossesString())
	end
end

local function SendDefeatToLuaMenu(gameID)
	local luaMenu = Spring.GetMenuName and Spring.SendLuaMenuMsg and Spring.GetMenuName()
	if luaMenu then
		Spring.SendLuaMenuMsg(LOST_MESSAGE .. " " .. gameID .. " " .. GetTimeString())
	end
end

local function SendResignToLuaMenu(gameID)
	local luaMenu = Spring.GetMenuName and Spring.SendLuaMenuMsg and Spring.GetMenuName()
	if luaMenu then
		Spring.SendLuaMenuMsg(RESIGN_MESSAGE .. " " .. gameID .. " " .. GetTimeString())
	end
end

local function SendMissionResult(shutdown)
	if missionResultSent or Spring.IsReplay() then
		return
	end
	
	if (not missionSustainedTime) then
		if shutdown then
			SendResignToLuaMenu(roguelikeBattleID)
		end
		return
	end
	missionResultSent = true
	
	if missionWon then
		SendVictoryToLuaMenu(roguelikeBattleID)
	else
		SendDefeatToLuaMenu(roguelikeBattleID)
	end
end

local function MissionGameOver(newMissionWon)
	if missionEndFrame and (newMissionWon == missionWon) then
		return
	end
	
	-- Don't turn lost missions into won missions.
	if newMissionWon and missionEndFrame then
		return
	end
	missionWon = newMissionWon
	missionEndFrame = Spring.GetGameFrame() + VICTORY_SUSTAIN_FRAMES
	missionEndTime = osClock()
	
	if WG.Music then
		WG.Music.PlayGameOverMusic(missionWon)
	end
end

-- Resign from within luaUI
local function MissionResign()
	Spring.SendLuaRulesMsg("roguelikeResign")
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Draw end screen

-- Mostly from pause screen (very_bad_soldier)

--Commons
local function ResetGl()
	glColor( { 1.0, 1.0, 1.0, 1.0 } )
	glLineWidth( 1.0 )
	glDepthTest(false)
	glTexture(false)
end

function IsOverWindow(x, y)
	if not missionEndTime then
		return false
	end
	if WG.Chili and WG.Chili.Screen0 and WG.Chili.Screen0.hoveredControl then
		return
	end

	if ((x > screenCenterX - boxWidth) and (y < screenCenterY + boxHeight) and
			(x < screenCenterX + boxWidth) and (y > screenCenterY - boxHeight)) then
		return true
	end
	return false
end

function widget:MousePress(x, y, button)
	if missionSustainedTime then
		local outsideSpring = select(6, spGetMouseState())
		if (not outsideSpring) and IsOverWindow(x, y) then
			SendMissionResult()
			if Spring.GetMenuName and Spring.GetMenuName() ~= "" then
				Spring.Reload("")
			else
				Spring.SendCommands("quitforce")
			end
			return true
		end
	end
end

local function SingleplayerMode()
	local playerList = Spring.GetPlayerList()
	return #playerList == 1
end

function widget:Update()
	if missionSustainedTime then
		local x, y, _, _, _, outsideSpring = spGetMouseState()
		if (not outsideSpring) and (IsOverWindow(x, y)) then
			mouseOver = true
		else
			mouseOver = false
		end
	end
	if gameNotStarted and SingleplayerMode() and not VFS.FileExists("mission.lua") then
		Spring.SendCommands("forcestart")
	end
	if firstUpdates then
		if TakeMouseOffEdge() and WG.ZoomToStart then
			WG.ZoomToStart()
		end
		if firstUpdates < 2 and briefingWindow then
			briefingWindow.BringToFrontFix()
		end
		firstUpdates = firstUpdates + 1
		if firstUpdates > 30 then
			firstUpdates = false
		end
	end
end

local function DrawGameOverScreen(now)
	local diffPauseTime = (now - missionEndTime)

	local text =  { 1.0, 1.0, (mouseOver and 0.9) or 1.0, 1.0 }
	local text2 =  { 0.95, 0.95, (mouseOver and 0.85) or 0.95, 1.0 }
	local outline =  { 0.4, 0.4, 0.4, 1.0 }
	local colorWnd = { 0.0, 0.0, 0.0, 0.6 }
	local mouseOverColor = { 0.022, 0.036, 0.03, 0.6 }

	-- Fade in
	local factor = min(maxTransparency_autoFade, max(diffPauseTime / autoFadeTime, minTransparency_autoFade))
	colorWnd[4] = colorWnd[4]*factor
	text[4] = text[4]*factor
	outline[4] = outline[4]*factor
	mouseOverColor[4] = mouseOverColor[4]*factor


	--draw window
	glPushMatrix()

	if mouseOver then
		glColor(mouseOverColor)
	else
		glColor(colorWnd)
	end

	glRect( wndX1, wndY1, wndX2, wndY2 )
	glRect( wndX1 - wndBorderSize, wndY1 + wndBorderSize, wndX2 + wndBorderSize, wndY2 - wndBorderSize)

	myFont:Begin()
	myFont:SetOutlineColor( outline )

	myFont:SetTextColor( text )
	myFont:Print((missionWon and "Victory") or "Defeat", (missionWon and victoryTextX) or defeatTextX, textY, fontSizeHeadline, "O" )

	if missionSustainedTime then
		local secondaryFactor = min(maxTransparency_autoFade, max((now - missionSustainedTime) / continueFadeInTime, 0))
		text2[4] = text2[4]*secondaryFactor
		myFont:SetTextColor( text2 )
		myFont:Print( "Click to continue", lowerTextX, textY - lineOffset, fontSizeAddon, "O" )
	end

	myFont:End()

	glPopMatrix()

	glTexture(false)
end

local function UpdateWindowCoords()
	screenx, screeny = Spring.GetViewGeometry()

	screenCenterX = screenx / 2
	screenCenterY = screeny / 2
	wndX1 = screenCenterX - boxWidth
	wndY1 = screenCenterY + boxHeight
	wndX2 = screenCenterX + boxWidth
	wndY2 = screenCenterY - boxHeight

	victoryTextX = wndX1 + (wndX2 - wndX1) * 0.12
	defeatTextX = wndX1 + (wndX2 - wndX1) * 0.15
	lowerTextX = wndX1 + (wndX2 - wndX1) * 0.30
	textY = wndY2 + (wndY1 - wndY2) * 0.3
	lineOffset = (wndY1 - wndY2) * 0.24

	yCenter = wndY2 + (wndY1 - wndY2) * 0.5
	xCut = wndX1 + (wndX2 - wndX1) * 0.19
end

function widget:ViewResize(viewSizeX, viewSizeY)
	UpdateWindowCoords()
end

function widget:DrawScreen()
	if missionEndTime then
		local now = osClock()
		DrawGameOverScreen(now)
		ResetGl()
	end
end

function widget:GameFrame(n)

	if missionEndFrame and missionEndFrame <= n then
		missionSustainedTime = osClock()
		missionEndFrame = nil
	end
	if wantPause then
		local paused = select(3, Spring.GetGameSpeed())
		if not paused then
			Spring.SendCommands("pause")
		end
		wantPause = false
		WG.PauseScreen_SetEnabled(false)
	end
end

function widget:Initialize()
	Chili = WG.Chili
	
	widgetHandler:RegisterGlobal('MissionGameOver', MissionGameOver)
	Spring.SendCommands("forcestart")
	
	WG.MissionResign = MissionResign

	myFont = glLoadFont(fontPath, fontSizeHeadline, nil, nil) -- FIXME: nils for #2564
	UpdateWindowCoords()
	
	local initMissionGameOver = GetGameRulesHax("MissionGameOver")
	if initMissionGameOver then
		MissionGameOver(initMissionGameOver == 1)
	end
end

function widget:Shutdown()
	SendMissionResult(true)
	glDeleteFont(myFont)
end
