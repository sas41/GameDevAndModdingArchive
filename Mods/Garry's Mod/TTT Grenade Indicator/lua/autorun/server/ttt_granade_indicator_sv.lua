resource.AddFile("materials/indicator/FlashOn.vmt")
resource.AddFile("materials/indicator/FlashOn.vtf")
resource.AddFile("materials/indicator/FlashOff.vmt")
resource.AddFile("materials/indicator/FlashOff.vtf")
local beepsound = "buttons/blip1.wav"
local soundlevel = 75 --Sound level in decibels. 75 is normal. Ranges from 20 to 180.
local soundpitch = 100 --Range is from 0 to 255. 100 is normal pitch.
local soundvolume = 1 --Ranging from 0-1. Determines output volume.
timer.Create( "Beeping",0.5, 0,function() 

	for i, target in pairs(ents.GetAll()) do
		
		if (target:GetClass()=="ttt_firegrenade_proj" or target:GetClass()=="ttt_basegrenade_proj" or target:GetClass()=="ttt_confgrenade_proj" or target:GetClass()=="ttt_smokegrenade_proj" or target:GetClass()=="ttt_cse_proj") then
		
			targetPos = target:GetPos()
			
			sound.Play("buttons/blip1.wav", targetPos, soundlevel, soundpitch, soundvolume)
			
		end	
		
	end
	
end)