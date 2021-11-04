--This is mostly Client Side

include("weapon_table.lua")
include ("perk_table.lua")

local SL_SIZE_WW = ScrW() - 20
local SL_SIZE_WH = 600

local SL_TABLE_W = SL_SIZE_WW / 6

local SL_POS_X = (ScrW()/2) - (SL_SIZE_WW/2)
local SL_POS_Y = (ScrH()/2) - (SL_SIZE_WH/2)

function pannel_weapons()
	
	TABLE_PRIMARY = Name_PrimaryTable

	TABLE_SECONDARY = Name_SecondaryTable

	TABLE_SPECIAL = Name_SpecialTable

	TABLE_PERK1 = Perk_One_Name

	TABLE_PERK2 = Perk_Two_Name

	TABLE_PERK3 = Perk_Three_Name
	
	AreWeaponsEnabled = 1--GetConVarNumber( "ffa_weapons" )
	ArePerksEnabled = 1--GetConVarNumber( "ffa_perks" )
	

	SL_pannel_bg = vgui.Create("DFrame")
	SL_pannel_bg:SetSize(SL_SIZE_WW, SL_SIZE_WH)
	SL_pannel_bg:SetPos( SL_POS_X, SL_POS_Y, 0 )
	SL_pannel_bg:SetVisible(true)
	SL_pannel_bg:SetDraggable(true)
	SL_pannel_bg:SetTitle("Loadout Menu")
	SL_pannel_bg:ShowCloseButton(true)
	SL_pannel_bg:MakePopup()

	if AreWeaponsEnabled == 1 then
	
		PRIM_list = vgui.Create( "DListView", SL_pannel_bg )
		PRIM_list:SetSize(SL_TABLE_W, 510)
		PRIM_list:SetPos(SL_TABLE_W*0,30)
		PRIM_list:AddColumn( "Primary Weapons" )
		PRIM_list:SetMultiSelect( false )
		for i=1,WEAPONS_NUMBER_PRIMARY do
			PRIM_list:AddLine( TABLE_PRIMARY[i] )
		end
		PRIM_list:SelectFirstItem()


		SCND_list = vgui.Create( "DListView", SL_pannel_bg )
		SCND_list:SetSize(SL_TABLE_W, 510)
		SCND_list:SetPos(SL_TABLE_W*1,30)
		SCND_list:SetMultiSelect( false )
		SCND_list:AddColumn( "Secondary Weapons" )	
		for i=1,WEAPONS_NUMBER_SECONDARY do
			SCND_list:AddLine( TABLE_SECONDARY[i] )
		end
		SCND_list:SelectFirstItem()


		SPCL_list = vgui.Create( "DListView", SL_pannel_bg )
		SPCL_list:SetSize(SL_TABLE_W, 510)
		SPCL_list:SetPos(SL_TABLE_W*2,30)
		SPCL_list:SetMultiSelect( false )
		SPCL_list:AddColumn( "Special Equipment" )	
		for i=1,WEAPONS_NUMBER_SPECIAL do
			SPCL_list:AddLine( TABLE_SPECIAL[i] )
		end
		SPCL_list:SelectFirstItem()

	end

	if ArePerksEnabled == 1 then

		PERK1_list = vgui.Create( "DListView", SL_pannel_bg )
		PERK1_list:SetSize(SL_TABLE_W, 510)
		PERK1_list:SetPos(SL_TABLE_W*3,30)
		PERK1_list:SetMultiSelect( false )
		PERK1_list:AddColumn( "Perk 1" )	
		for i=1,Perk_One_Amount do
			PERK1_list:AddLine( TABLE_PERK1[i] )
		end
		PERK1_list:SelectFirstItem()

		PERK2_list = vgui.Create( "DListView", SL_pannel_bg )
		PERK2_list:SetSize(SL_TABLE_W, 510)
		PERK2_list:SetPos(SL_TABLE_W*4,30)
		PERK2_list:SetMultiSelect( false )
		PERK2_list:AddColumn( "Perk 2" )	
		for i=1,Perk_Two_Amount do
			PERK2_list:AddLine( TABLE_PERK2[i] )
		end
		PERK2_list:SelectFirstItem()

		PERK3_list = vgui.Create( "DListView", SL_pannel_bg )
		PERK3_list:SetSize(SL_TABLE_W, 510)
		PERK3_list:SetPos(SL_TABLE_W*5,30)
		PERK3_list:SetMultiSelect( false )
		PERK3_list:AddColumn( "Perk 3" )	
		for i=1,Perk_Three_Amount do
			PERK3_list:AddLine( TABLE_PERK3[i] )
		end
		PERK3_list:SelectFirstItem()

	end


	DermaButton = vgui.Create( "DButton", SL_pannel_bg )
	DermaButton:SetText( "Set Loadout!" )
	DermaButton:SetPos( 10 , 540 )
	DermaButton:SetSize( SL_SIZE_WW - 20, 50)
	DermaButton.DoClick = function ()

		LAODOUT_SEND = tostring(PRIM_list:GetSelectedLine())..","..tostring(SCND_list:GetSelectedLine())..","..tostring(SPCL_list:GetSelectedLine())..","..tostring(PERK1_list:GetSelectedLine())..","..tostring(PERK2_list:GetSelectedLine())..","..tostring(PERK3_list:GetSelectedLine())

		print(LAODOUT_SEND)
		RunConsoleCommand("ffa_cl_set_loadout", LAODOUT_SEND) --Loadout Send is the argument to the command (string)
	
	end

end

concommand.Add( "ffa_weapons", pannel_weapons)
usermessage.Hook("hook_panel_weapons", pannel_weapons)