PlayerKills = {}

function SetupPlayer(ply)
	PlayerKills[ply] = 0
end
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawn", SetupPlayer )

function KillStreaks( victim, weapon, killer )
	PlayerKills[victim] = 0
	if killer:IsPlayer( ) then

		PlayerKills[killer] = PlayerKills[killer] + 1

		if PlayerKills[killer] == 4 then

		    --ChatBroadcast(Text)

			killer:SetArmor(150)
			killer:SetHealth(100)

		elseif PlayerKills[killer] == 8 then

			killer:SetArmor(100)
			killer:SetHealth(100)

		elseif PlayerKills[killer] == 15 then

			killer:SetArmor(100)
			killer:SetHealth(100)
				
		end

	end

end
hook.Add( "PlayerDeath", "KillStreakHook", KillStreaks )