include("shared.lua")

surface.CreateFont( "TimerFont", {
font = "Arial",
size = 22,
weight = 500,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = false,
outline = true,
} )

function GM:HUDPaint()

	self.BaseClass:HUDPaint()

	surface.SetTextColor(50, 255, 50, 255)
	surface.SetTextPos(ScrW() / 2 - 80,ScrH() - 32)
	surface.SetFont("TimerFont")
	REMAINING_TIME =  math.Round((ROUND_TIME + ROUND_BREAK )- CurTime())


	TIME_DISPLAY = "Time Remaining: "..REMAINING_TIME
	if REMAINING_TIME > -1 then
		if REMAINING_TIME > ROUND_TIME then			
			surface.DrawText( "Freeze Time, Prepare to Fight!" )
		else
			surface.DrawText( TIME_DISPLAY )
		end
	else
		surface.DrawText( "Game Over!" )
		ShowWinner()
	end


end

SCOREBOARD_TOGGLE = false

function ShowWinner()
	if SCOREBOARD_TOGGLE == false then
		SCOREBOARD_TOGGLE = true
		RunConsoleCommand("+showscores")
		timer.Create("CloseScoreBoard", 10, 1, function()  RunConsoleCommand("-showscores") end )
	end
end


--Loadout UI
include("loadout_UI.lua")