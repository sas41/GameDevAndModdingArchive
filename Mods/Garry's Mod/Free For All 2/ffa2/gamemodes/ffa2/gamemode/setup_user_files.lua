function SetUpFile(ply)

	PLAYER_UID = ply:UniqueID()
	file.Write("ffa2_data/player/"..PLAYER_UID..".txt", "1,1,1,1,1,1")
	
end
hook.Add( "PlayerInitialSpawn", "playerInitialSpawn", SetUpFile )