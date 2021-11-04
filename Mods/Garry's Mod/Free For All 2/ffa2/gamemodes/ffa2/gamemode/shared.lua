GM.Name = "Free For All V2.0"
GM.Author = "SAS41"
GM.Email = "N/A"
GM.Website = "N/A"

team.SetUp( 0, "Soldier", Color(255, 0, 0) )

ROUND_BREAK = GetConVarNumber( "ffa_freezetime" )
ROUND_TIME = GetConVarNumber( "ffa_maxtime" )

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

function ChatBroadcast(Text)
	for k, v in ipairs(player.GetAll()) do
		v:ChatPrint(Text)
	end
end

--Round Timing and etc.
include("round.lua")

--Killstreak manager goes here
include("killstreaks.lua")

--SlowMotion Manager
include("slow_motion.lua")

--LOADOUT SYSTEM
include("loadout_system.lua")

--SPAWN PROTECTION
include("spawn_protection.lua")

--LEGS SYSTEM
include("sh_legs.lua")