function GM:PlayerSetModel( ply )

	RANDOM_MODEL_NUBMER = math.random( 1,8 )

	if RANDOM_MODEL_NUBMER == 1 then
		ply:SetModel( "models/player/riot.mdl" )
	elseif RANDOM_MODEL_NUBMER == 2 then
		ply:SetModel( "models/player/swat.mdl" )
	elseif RANDOM_MODEL_NUBMER == 3 then
		ply:SetModel( "models/player/gasmask.mdl" )
	elseif RANDOM_MODEL_NUBMER == 4 then
		ply:SetModel( "models/player/urban.mdl" )		
	elseif RANDOM_MODEL_NUBMER == 5 then
		ply:SetModel( "models/player/arctic.mdl" )
	elseif RANDOM_MODEL_NUBMER == 6 then
		ply:SetModel( "models/player/guerilla.mdl" )
	elseif RANDOM_MODEL_NUBMER == 7 then
		ply:SetModel( "models/player/leet.mdl" )
	elseif RANDOM_MODEL_NUBMER == 8 then
		ply:SetModel( "models/player/phoenix.mdl" )
	end
	
end