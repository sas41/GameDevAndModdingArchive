function TriggerSlowMotion()

	IsSlowMoOn = GetConVarNumber( "ffa_slowmotion" )
	SlowMoChance = GetConVarNumber( "ffa_slowmotion_chance" )
	SlowMoDuration = GetConVarNumber( "ffa_slowmotion_duration" )

	if IsSlowMoOn == 1 then

		SlowMoRoll = math.random( 1,100 )

		if (SlowMoRoll < SlowMoChance+1) then

			game.SetTimeScale(0.5)

			timer.Create("SlowMoTimer", SlowMoDuration, 1, function()
				game.SetTimeScale(1)
			end)

		end

	end

end
hook.Add( "PlayerDeath", "SlowMoHook", TriggerSlowMotion )

function SlowDownSounds(soundEntity)

	local customPitch = soundEntity.Pitch

	if ( game.GetTimeScale() != 1 ) then
		customPitch = customPitch * game.GetTimeScale()
		soundEntity.Pitch = math.Clamp( customPitch, 0, 255 )
	end

	if ( CLIENT && engine.GetDemoPlaybackTimeScale() != 1 ) then

		soundEntity.Pitch = math.Clamp( soundEntity.Pitch * engine.GetDemoPlaybackTimeScale(), 0, 255 )
		return true
		
	end

end
hook.Add( "EntityEmitSound", "SlowMoSoundHook", SlowDownSounds)