function GivePerks(ply)

	--We create this time to ensure that perks apply AFTER the player entity is completely set up, if we don't wait it is likely that
		
	TimerName = ply:Nick() .. "perktimer" --give this timer to every player individually, so no overlap is there!

	timer.Create(TimerName, 0.01, 1, function() 

		PLAYER_UID = ply:UniqueID()

		PLAYER_LOUDOUT = file.Read("ffa2_data/player/"..PLAYER_UID..".txt") --Read the file to get the players loadout as one long string.
		PLAYER_PERKS = string.Explode( ",", PLAYER_LOUDOUT ) --"Explode" the string in to a table using the comma as a dividing character

		perk1		=  tonumber(PLAYER_PERKS[4])
		perk2		=  tonumber(PLAYER_PERKS[5])
		perk3		=  tonumber(PLAYER_PERKS[6])

		--ChatBroadcast("P1 = "..PLAYER_PERKS[4])
		--ChatBroadcast("P2 = "..PLAYER_PERKS[5])
		--ChatBroadcast("P3 = "..PLAYER_PERKS[6])

		if (perk1 == 1) then
			perk_sprint(ply)
		elseif (perk1 == 2) then
			perk_jump(ply)
		end

		if (perk2 == 1) then
			perk_ammo_primary(ply)
		elseif (perk2 == 2) then
			perk_ammo_special(ply)
		end

		if (perk3 == 1) then
			perk_health(ply)
		elseif (perk3 == 2) then
			perk_armor(ply)
		end

	end)

end

function perk_sprint(ply)

	currentSpeed = ply:GetRunSpeed() --Get current Run Speed
	ply:SetRunSpeed(currentSpeed + (currentSpeed/2)) --Add 50% to it

end

function perk_jump(ply)

	currentPower = ply:GetJumpPower() --Get current Jump Power
	ply:SetJumpPower(currentPower + (currentPower/2)) --Add %50 to it

end

function perk_ammo_primary(ply)

	ply:GiveAmmo( 30, "5.45x39MM", true )
	ply:GiveAmmo( 30, "5.56x45MM", true )
	ply:GiveAmmo( 30, "7.62x51MM", true )
	ply:GiveAmmo( 30, "9x19MM", true )
	ply:GiveAmmo( 30, ".45 ACP", true )
	ply:GiveAmmo( 20, "12 Gauge", true )
	ply:GiveAmmo( 10, ".338 Lapua", true )

end

function perk_ammo_special(ply)
	
end

function perk_health(ply)

	currentHealth = ply:Health() --Get current Health
	increasedHealth = (currentHealth + ((currentHealth/10)*3)) --Increase the valua by 30 Pecent
	ply:SetMaxHealth(increasedHealth) --Set Max Health to the increased Valua
	ply:SetHealth(increasedHealth) --Set Health to the increased Valua

end

function perk_armor(ply)
	
	currentArmor = ply:Armor() --Get current Armor
	ply:SetArmor( currentArmor + 15 ) --Add 30 to it

end