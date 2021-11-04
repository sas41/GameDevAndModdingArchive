function PreStart()

	ChatBroadcast(ROUND_BREAK.." second Freeze time, Prepare to Fight!")

	PRESTART_COUNTER = 0

	timer.Create("PreFreeze", 1, ROUND_BREAK, function()

   		PRESTART_COUNTER = PRESTART_COUNTER + 1

		for _, ply in ipairs( player.GetAll() ) do
	   		ply:Freeze( true )
		end

		if PRESTART_COUNTER == ROUND_BREAK then
			RoundStart()
		end
	end)

end



function RoundStart()

	ChatBroadcast("Freeze Time Over, GO GO GO!")

	for _, ply in ipairs( player.GetAll() ) do
   		ply:Freeze( false )
	end
	
	timer.Create("RoundTime", ROUND_TIME, 1, RoundEnd )

end



function RoundEnd()

	ChatBroadcast("Game Over! Map Vote in 15 seconds!")

	for _, ply in ipairs( player.GetAll() ) do
   		ply:Freeze( true )
	end

end

PreStart() --start the round