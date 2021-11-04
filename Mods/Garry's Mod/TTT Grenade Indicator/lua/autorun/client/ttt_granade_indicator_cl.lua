surface.CreateFont( "TheDefaultSettings", {
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
 outline = false
} )

local coloralpha = 250
local indicator = surface.GetTextureID("indicator/FlashOn")  
local indicatorstate = 1
local indicationsound = Sound("Grenade.Blip")
 

function HoveringNames()

	for i, target in pairs(ents.GetAll()) do
	
		if (target:GetClass()=="ttt_firegrenade_proj" or target:GetClass()=="ttt_basegrenade_proj" or target:GetClass()=="ttt_confgrenade_proj" or target:GetClass()=="ttt_smokegrenade_proj" or target:GetClass()=="ttt_cse_proj") then
		
			targetPos = target:GetPos() + Vector(0,0,20)
			local targetDistance = math.floor((LocalPlayer():GetPos():Distance( targetPos ))/40)
			local targetScreenpos = targetPos:ToScreen()
			coloralpha = 250 -  (targetDistance/30) * 250
			if(targetDistance<21)then
				
				surface.SetTexture( indicator )
				
				surface.SetDrawColor ( 255, 255, 255, coloralpha )
				
				
				local screenPosX =  tonumber(targetScreenpos.x)
				local screenPosY =  tonumber(targetScreenpos.y)
				if(screenPosX<0) then
					screenPosX = 30
				elseif(screenPosX>ScrW()) then
					screenPosX=ScrW() -30
				end
				if(screenPosY<0) then
					screenPosY = 40
				elseif(screenPosY>ScrH()) then
					screenPosY=ScrH()-40
				end
				
				surface.DrawTexturedRect( screenPosX-30,screenPosY-40, 60, 60 )
				
			end
			
		end	
		
	end
	
end
hook.Add("HUDPaint", "HoveringNames", HoveringNames)

timer.Create( "Blinking",0.5, 0,function() 
	if(indicatorstate==1 )then
		indicator = surface.GetTextureID("indicator/FlashOn")
		indicatorstate=0
	elseif(indicatorstate==0) then
		indicator = surface.GetTextureID("indicator/FlashOff")
		indicatorstate=1
	end
	--objector:EmitSound(indicationsound)
end)