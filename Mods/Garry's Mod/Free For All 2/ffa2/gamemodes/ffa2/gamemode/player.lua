AddCSLuaFile()
DEFINE_BASECLASS( "player_default" )

local PLAYER = {} 

--
-- See gamemodes/base/player_class/player_default.lua for all overridable variables
--

PLAYER.WalkSpeed 			= GetConVarNumber( "ffa_base_walkingspeed" )
PLAYER.RunSpeed				= GetConVarNumber( "ffa_base_sprintingspeed" )
PLAYER.JumpPower			= GetConVarNumber( "ffa_base_jumppower" )

PLAYER.TeammateNoCollide 	= false

PLAYER.UseVMHands			= true

PLAYER.StartArmor			= GetConVarNumber( "ffa_base_armor" )
PLAYER.StartHealth			= GetConVarNumber( "ffa_base_health" )

function PLAYER:Loadout()

	--self.Player:GiveAmmo( 60, "AR2", true )
	--self.Player:GiveAmmo( 60, "SMG1", true )
	--self.Player:GiveAmmo( 28, "Buckshot", true )
	--self.Player:GiveAmmo( 36, "357", true )
	--self.Player:GiveAmmo( 120, "Pistol", true )

	self.Player:GiveAmmo( 90, "5.45x39MM", true )
	self.Player:GiveAmmo( 90, "5.56x45MM", true )
	self.Player:GiveAmmo( 90, "7.62x51MM", true )
	self.Player:GiveAmmo( 90, "9x19MM", true )
	self.Player:GiveAmmo( 90, ".45 ACP", true )
	self.Player:GiveAmmo( 40, "12 Gauge", true )
	self.Player:GiveAmmo( 30, ".338 Lapua", true )

	self.Player:GiveAmmo( 36, ".50 AE", true )
	self.Player:GiveAmmo( 36, ".44 Magnum", true )
	self.Player:GiveAmmo( 36, ".357 Magnum", true )
	self.Player:GiveAmmo( 36, ".30 Winchester", true )
	self.Player:GiveAmmo( 60, ".40 S&W", true )
	self.Player:GiveAmmo( 60, "FN 5.7x28MM", true )

	self.Player:Give( "weapon_crowbar" )

end

player_manager.RegisterClass( "player_soldier", PLAYER, "player_default" )