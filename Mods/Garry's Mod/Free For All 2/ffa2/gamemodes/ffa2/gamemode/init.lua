AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

AddCSLuaFile("weapon_table.lua")
AddCSLuaFile("perk_table.lua")
AddCSLuaFile("loadout_UI.lua")

AddCSLuaFile("round.lua")
AddCSLuaFile("killstreaks.lua")

include("shared.lua")
include("player.lua")

file.CreateDir( "ffa2_data" )
file.CreateDir( "ffa2_data/player" )

function GM:PlayerConnect( name, ip )
	print("Player: " .. name .. ", has joined the game.")
end

function GM:PlayerInitialSpawn( ply )
	print("Player: " .. ply:Nick() .. ", has spawned.")
	
	player_manager.SetPlayerClass( ply, "player_soldier" )
end

function GM:PlayerAuthed( ply, steamID, uniqueID )
	print("Player: " .. ply:Nick() .. ", has gotten authed.")
end

--Random Player Models
include("random_player_model.lua")
