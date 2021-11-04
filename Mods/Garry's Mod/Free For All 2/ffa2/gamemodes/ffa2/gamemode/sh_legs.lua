--[[ 
	GMOD LEGS 3.5.1 
	@Valkyrie, @blackops7799
	
	Changelog:
	3.6:
	[FIX] Models not working with certain playermodels ( should work with all of them now )
	[ADD] cl_legs updates, no need for restarts ( yay )
	[ADD] legs now render in vehicles.
	[REMOVE] menu and death calc view.
]]--

local LegsBool = CreateConVar( "cl_legs", "1", { FCVAR_ARCHIVE, }, "Enable/Disable the rendering of the legs" )
-- local LegsBool = Legs:GetBool()

g_LegsVer = "3.6"

if SERVER then
    AddCSLuaFile( "sh_legs.lua" )
	
	local Chat = CreateConVar( "sv_legchat", 	"0", {FCVAR_SERVER_CAN_EXECUTE},  "Enable/Disable the chat adverts") 
	local ChatBool = Chat:GetBool()
	
	if ChatBool then
		Adverts = {"This server is running Gmod Legs " .. g_LegsVer .. " by Valkyrie and blackops7799", "Get Gmod Legs @ http://steamcommunity.com/sharedfiles/filedetails/?id=112806637"}

		function ChatAdverts ( )
			local text = table.Random(Adverts);
			chat.AddText( Color( 255, 255, 255 ), "[", Color( 0, 255, 25 ), "GLegs 3", Color( 255, 255, 255 ), "] ", Color( 255, 255, 255 ), text )
		end
		if !game.SinglePlayer() then 
			timer.Create("ChatAdverts", 120, 0, ChatAdverts)
		end
	end

    return
end

if CLIENT then
    local Legs = {}
    Legs.LegEnt = nil
     
    function ShouldDrawLegs()
		if LegsBool:GetBool() then
			return  IsValid( Legs.LegEnt ) 					and
					( LocalPlayer():Alive() or ( LocalPlayer().IsGhosted and LocalPlayer():IsGhosted() ) ) and
					GetViewEntity() == LocalPlayer() 		and
					!LocalPlayer():ShouldDrawLocalPlayer() 	and
					!LocalPlayer():GetObserverTarget() 		and
					!LocalPlayer().ShouldDisableLegs	
		else
			return false
		end
    end
     
    function GetPlayerLegs( ply )
        return ply and ply != LocalPlayer() and ply or ( ShouldDrawLegs() and Legs.LegEnt or LocalPlayer() )
    end
    
    function Legs:FixModelName( mdl )
        mdl = mdl:lower()
        return mdl
    end

    function Legs:SetUp()
        self.LegEnt = ClientsideModel( Legs:FixModelName( LocalPlayer():GetModel() ), RENDER_GROUP_OPAQUE_ENTITY )
        self.LegEnt:SetNoDraw( true )
        self.LegEnt:SetSkin( LocalPlayer():GetInfoNum( "cl_playerskin", 0 ) )
        self.LegEnt:SetMaterial( LocalPlayer():GetMaterial() )
        self.LegEnt:SetColor( LocalPlayer():GetColor() )
				local groups = LocalPlayer():GetInfo( "cl_playerbodygroups" );
		if ( groups == nil ) then groups = "" end
		local groups = string.Explode( " ", groups )
		for k = 0, LocalPlayer():GetNumBodyGroups() - 1 do
			self.LegEnt:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
		end
		self.LegEnt.GetPlayerColor = function() 
			return Vector( GetConVarString( "cl_playercolor" ) ) 
		end
		self.LegEnt.LastTick = 0
    end
     
     
    Legs.PlaybackRate = 1
    Legs.Sequence = nil
    Legs.Velocity = 0
    Legs.OldWeapon = nil
    Legs.HoldType = nil
     
    Legs.BoneHoldTypes = { 
							["none"] = {
								"ValveBiped.Bip01_Head1",
								"ValveBiped.Bip01_Neck1",
								"ValveBiped.Bip01_Spine4",
								"ValveBiped.Bip01_Spine2",
                            },
                            ["default"] = {
								"ValveBiped.Bip01_Head1",
								"ValveBiped.Bip01_Neck1",
								"ValveBiped.Bip01_Spine4",
								"ValveBiped.Bip01_Spine2",
								"ValveBiped.Bip01_L_Hand",
								"ValveBiped.Bip01_L_Forearm",
								"ValveBiped.Bip01_L_Upperarm",
								"ValveBiped.Bip01_L_Clavicle",
								"ValveBiped.Bip01_R_Hand",
								"ValveBiped.Bip01_R_Forearm",
								"ValveBiped.Bip01_R_Upperarm",
								"ValveBiped.Bip01_R_Clavicle",
								"ValveBiped.Bip01_L_Finger4",
								"ValveBiped.Bip01_L_Finger41",
								"ValveBiped.Bip01_L_Finger42",
								"ValveBiped.Bip01_L_Finger3",
								"ValveBiped.Bip01_L_Finger31",
								"ValveBiped.Bip01_L_Finger32",
								"ValveBiped.Bip01_L_Finger2",
								"ValveBiped.Bip01_L_Finger21",
								"ValveBiped.Bip01_L_Finger22",
								"ValveBiped.Bip01_L_Finger1",
								"ValveBiped.Bip01_L_Finger11",
								"ValveBiped.Bip01_L_Finger12",
								"ValveBiped.Bip01_L_Finger0",
								"ValveBiped.Bip01_L_Finger01",
								"ValveBiped.Bip01_L_Finger02",
								"ValveBiped.Bip01_R_Finger4",
								"ValveBiped.Bip01_R_Finger41",
								"ValveBiped.Bip01_R_Finger42",
								"ValveBiped.Bip01_R_Finger3",
								"ValveBiped.Bip01_R_Finger31",
								"ValveBiped.Bip01_R_Finger32",
								"ValveBiped.Bip01_R_Finger2",
								"ValveBiped.Bip01_R_Finger21",
								"ValveBiped.Bip01_R_Finger22",
								"ValveBiped.Bip01_R_Finger1",
								"ValveBiped.Bip01_R_Finger11",
								"ValveBiped.Bip01_R_Finger12",
								"ValveBiped.Bip01_R_Finger0",
								"ValveBiped.Bip01_R_Finger01",
								"ValveBiped.Bip01_R_Finger02"
                            },
                            ["vehicle"] = {
								"ValveBiped.Bip01_Head1",
								"ValveBiped.Bip01_Neck1",
								"ValveBiped.Bip01_Spine4",
								"ValveBiped.Bip01_Spine2",
                            }
                        }
                     
    Legs.BonesToRemove = {}
    Legs.BoneMatrix = nil
     
    function Legs:WeaponChanged( weap )
        if IsValid( self.LegEnt ) then
            if IsValid( weap ) then
                self.HoldType = weap:GetHoldType()
            else
                self.HoldType = "none"
            end
     
			for i = 0, self.LegEnt:GetBoneCount() do
				self.LegEnt:ManipulateBoneScale( i, Vector(1,1,1) )
				self.LegEnt:ManipulateBonePosition( i, vector_origin )
			end
	
            Legs.BonesToRemove = {
                "ValveBiped.Bip01_Head1"
            }
            if !LocalPlayer():InVehicle() then
                Legs.BonesToRemove = Legs.BoneHoldTypes[ Legs.HoldType ] or Legs.BoneHoldTypes[ "default" ]
            else
                Legs.BonesToRemove = Legs.BoneHoldTypes[ "vehicle" ]
            end
            for _, v in pairs( Legs.BonesToRemove ) do
                local boneId = self.LegEnt:LookupBone(v)
                if boneId then
                    self.LegEnt:ManipulateBoneScale(boneId, vector_origin)
                    self.LegEnt:ManipulateBonePosition(boneId, Vector(-10,-10,0))
                end
            end
        end
    end
     
    Legs.BreathScale = 0.5
    Legs.NextBreath = 0
     
    function Legs:Think( maxseqgroundspeed )
		if not LocalPlayer():Alive() then
			Legs:SetUp()
			return;
		end
		
        if IsValid( self.LegEnt ) then
			
            if LocalPlayer():GetActiveWeapon() != self.OldWeapon then
                self.OldWeapon = LocalPlayer():GetActiveWeapon()
                self:WeaponChanged( self.OldWeapon )
            end

                     
            if self.LegEnt:GetModel() != self:FixModelName( LocalPlayer():GetModel() ) then
                self.LegEnt:SetModel( self:FixModelName( LocalPlayer():GetModel() ) )
            end
             
            self.LegEnt:SetMaterial( LocalPlayer():GetMaterial() )
            self.LegEnt:SetSkin( LocalPlayer():GetSkin() )
     
            self.Velocity = LocalPlayer():GetVelocity():Length2D()
             
            self.PlaybackRate = 1
     
            if self.Velocity > 0.5 then
                if maxseqgroundspeed < 0.001 then
                    self.PlaybackRate = 0.01
                else
                    self.PlaybackRate = self.Velocity / maxseqgroundspeed
                    self.PlaybackRate = math.Clamp( self.PlaybackRate, 0.01, 10 )
                end
            end
             
            self.LegEnt:SetPlaybackRate( self.PlaybackRate )
             
            self.Sequence = LocalPlayer():GetSequence()
             
            if ( self.LegEnt.Anim != self.Sequence ) then
                self.LegEnt.Anim = self.Sequence
                self.LegEnt:ResetSequence( self.Sequence )
            end
             
            self.LegEnt:FrameAdvance( CurTime() - self.LegEnt.LastTick )
            self.LegEnt.LastTick = CurTime()
             
            Legs.BreathScale = sharpeye and sharpeye.GetStamina and math.Clamp( math.floor( sharpeye.GetStamina() * 5 * 10 ) / 10, 0.5, 5 ) or 0.5
             
            if Legs.NextBreath <= CurTime() then
                Legs.NextBreath = CurTime() + 1.95 / Legs.BreathScale
                self.LegEnt:SetPoseParameter( "breathing", Legs.BreathScale )
            end
             
			self.LegEnt:SetPoseParameter( "move_x", ( LocalPlayer():GetPoseParameter( "move_x" ) * 2 ) - 1 ) -- Translate the walk x direction
			self.LegEnt:SetPoseParameter( "move_y", ( LocalPlayer():GetPoseParameter( "move_y" ) * 2 ) - 1 ) -- Translate the walk y direction
			self.LegEnt:SetPoseParameter( "move_yaw", ( LocalPlayer():GetPoseParameter( "move_yaw" ) * 360 ) - 180 ) -- Translate the walk direction
			self.LegEnt:SetPoseParameter( "body_yaw", ( LocalPlayer():GetPoseParameter( "body_yaw" ) * 180 ) - 90 ) -- Translate the body yaw
			self.LegEnt:SetPoseParameter( "spine_yaw",( LocalPlayer():GetPoseParameter( "spine_yaw" ) * 180 ) - 90 ) -- Translate the spine yaw

           	if LocalPlayer():InVehicle() then
				self.LegEnt:SetColor( color_transparent )
				self.LegEnt:SetPoseParameter( "vehicle_steer", ( LocalPlayer():GetVehicle():GetPoseParameter( "vehicle_steer" ) * 2 ) - 1 ) -- Translate the vehicle steering
			end
        end
    end
     
    hook.Add( "UpdateAnimation", "Legs:UpdateAnimation", function( ply, velocity, maxseqgroundspeed )
        if ply == LocalPlayer() then
            if IsValid( Legs.LegEnt ) then
                Legs:Think( maxseqgroundspeed )
            else
                Legs:SetUp()
            end
        end
    end )
     
    Legs.RenderAngle = nil
    Legs.BiaisAngle = nil
    Legs.RadAngle = nil
    Legs.RenderPos = nil
    Legs.RenderColor = {}
    Legs.ClipVector = vector_up * -1
    Legs.ForwardOffset = -24
     
    hook.Add( "RenderScreenspaceEffects", "Legs:Render", function()
        cam.Start3D( EyePos(), EyeAngles() )
            if ShouldDrawLegs() then
             
                Legs.RenderPos = LocalPlayer():GetPos()
                if LocalPlayer():InVehicle() then
                    Legs.RenderAngle = LocalPlayer():GetVehicle():GetAngles()
                    Legs.RenderAngle:RotateAroundAxis( Legs.RenderAngle:Up(), 90 )
                else
                    Legs.BiaisAngles = sharpeye_focus and sharpeye_focus.GetBiaisViewAngles and sharpeye_focus:GetBiaisViewAngles() or LocalPlayer():EyeAngles()
                    Legs.RenderAngle = Angle( 0, Legs.BiaisAngles.y, 0 )
                    Legs.RadAngle = math.rad( Legs.BiaisAngles.y )
                    Legs.ForwardOffset = -22
                    Legs.RenderPos.x = Legs.RenderPos.x + math.cos( Legs.RadAngle ) * Legs.ForwardOffset
                    Legs.RenderPos.y = Legs.RenderPos.y + math.sin( Legs.RadAngle ) * Legs.ForwardOffset
                     
                    if LocalPlayer():GetGroundEntity() == NULL then
                        Legs.RenderPos.z = Legs.RenderPos.z + 8
                        if LocalPlayer():KeyDown( IN_DUCK ) then
                            Legs.RenderPos.z = Legs.RenderPos.z - 28
                        end
                    end
                end
                 
                Legs.RenderColor = LocalPlayer():GetColor()
                 
                local bEnabled = render.EnableClipping( true )
                    render.PushCustomClipPlane( Legs.ClipVector, Legs.ClipVector:Dot( EyePos() ) ) 
                        render.SetColorModulation( Legs.RenderColor.r / 255, Legs.RenderColor.g / 255, Legs.RenderColor.b / 255 )
                            render.SetBlend( Legs.RenderColor.a / 255 )
                                hook.Call( "PreLegsDraw", GAMEMODE, Legs.LegEnt )       
                                    Legs.LegEnt:SetRenderOrigin( Legs.RenderPos )
                                    Legs.LegEnt:SetRenderAngles( Legs.RenderAngle )
                                    Legs.LegEnt:SetupBones()
                                    Legs.LegEnt:DrawModel()
                                    Legs.LegEnt:SetRenderOrigin()
                                    Legs.LegEnt:SetRenderAngles()
                                hook.Call( "PostLegsDraw", GAMEMODE, Legs.LegEnt )
                            render.SetBlend( 1 )
                        render.SetColorModulation( 1, 1, 1 )
                    render.PopCustomClipPlane()
                render.EnableClipping( bEnabled )
            end
        cam.End3D()
    end )
	
	concommand.Add("cl_togglelegs", function (Player)
		if LegsBool:GetBool() then
			RunConsoleCommand("cl_legs", "0");
		else
			RunConsoleCommand("cl_legs", "1");
		end
	end)
end   
