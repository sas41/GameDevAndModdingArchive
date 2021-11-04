--This is mostly Serverside

include("weapon_table.lua")
include("perks.lua")
include("setup_user_files.lua")


function HandOut(ply)

	IsSpawnProtectionEnabled = GetConVarNumber( "ffa_spawnprotection" )
	AreWeaponsEnabled = GetConVarNumber( "ffa_weapons" )
	ArePerksEnabled = GetConVarNumber( "ffa_perks" )

	if AreWeaponsEnabled == 1 then
		GiveWeapons(ply)
	end

	if ArePerksEnabled == 1 then
		GivePerks(ply)
	end

end
hook.Add( "PlayerSpawn", "HandoutLoadoutHook", HandOut )



function GiveWeapons(ply)

	PLAYER_UID = ply:UniqueID()

	LOADOUT_PRIMARY = Weapon_PrimaryTable

	LOADOUT_SECONDARY = Weapon_SecondaryTable

	LOADOUT_SPECIAL = Weapon_SpecialTable

	PLAYER_LOUDOUT = file.Read("ffa2_data/player/"..PLAYER_UID..".txt") --Read the file to get the players loadout as one long string.
	PLAYER_LOADOUT_LIST = string.Explode( ",", PLAYER_LOUDOUT ) --"Explode" the string in to a table using the comma as a dividing character

	--ChatBroadcast("PR = "..PLAYER_LOADOUT_LIST[1]) --Broadcast a string on the server
	--ChatBroadcast("SR = "..PLAYER_LOADOUT_LIST[2]) --Broadcast a string on the server
	--ChatBroadcast("SE = "..PLAYER_LOADOUT_LIST[3]) --Broadcast a string on the server

	PLAYER_LOADOUT_PRIMARY		=  tonumber(PLAYER_LOADOUT_LIST[1]) --Convert a String to a number
	PLAYER_LOADOUT_SECONDARY	=  tonumber(PLAYER_LOADOUT_LIST[2]) --Convert a String to a number
	PLAYER_LOADOUT_SPECIAL		=  tonumber(PLAYER_LOADOUT_LIST[3]) --Convert a String to a number
	
	ply:Give( LOADOUT_PRIMARY[PLAYER_LOADOUT_PRIMARY] ) --ply is the netity, :Give is the function to apply to that entity and then we get the name of the object we are going to give by looking at a table, using a number to pinpoint the exact element on that string, like this :Give(TABLE[NUMBER IN THE TABLE])
	ply:Give( LOADOUT_SECONDARY[PLAYER_LOADOUT_SECONDARY] ) --ply is the netity, :Give is the function to apply to that entity and then we get the name of the object we are going to give by looking at a table, using a number to pinpoint the exact element on that string, like this :Give(TABLE[NUMBER IN THE TABLE]
	ply:Give( LOADOUT_SPECIAL[PLAYER_LOADOUT_SPECIAL] ) --ply is the netity, :Give is the function to apply to that entity and then we get the name of the object we are going to give by looking at a table, using a number to pinpoint the exact element on that string, like this :Give(TABLE[NUMBER IN THE TABLE]

end



function SetLoadout(ply, command, args, public)
	file.Write("ffa2_data/player/"..ply:UniqueID()..".txt", args[1])
end
concommand.Add( "ffa_cl_set_loadout", SetLoadout)



function BringUpLoadoutMenu( ply )
    umsg.Start( "hook_panel_weapons", ply ) --Send the contents of "MyMenu" to the client
    umsg.End()
end
hook.Add("ShowSpare2", "MenuHook", BringUpLoadoutMenu) --Default F4 Menu