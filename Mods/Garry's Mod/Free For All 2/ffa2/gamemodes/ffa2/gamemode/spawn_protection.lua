function SpawnProtection(ply)

	if IsSpawnProtectionEnabled > 0 then

		SP_TIME = GetConVarNumber( "ffa_spawnprotection" )

		ply:GodEnable()

		TimerName = ply:Nick().."spawnprotectiontimer"

		timer.Create(TimerName, SP_TIME, 1, function()
			ply:GodDisable()
		end )

	end
	
end
hook.Add( "PlayerSpawn", "SpawnProtectionHook", SpawnProtection )