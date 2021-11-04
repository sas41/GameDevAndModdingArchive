--Menu coding can be found below
menuPosW = (defaultResolutionW/2)-50
menuPosH = 200

local player1Keyboard = true
local player2Keyboard = true
local player3Keyboard = true
local player4Keyboard = true

--0000000000==Main Menu==0000000000--
function createAllUIElements()
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------Main Menu
------------------------------------------------------------------
------------------------------------------------------------------
	
	--Start Button
	StartButton = loveframes.Create("imagebutton")
	StartButton:SetState("mainmenu")
	StartButton:SetImage(button_Image_Start)
	StartButton:SetPos(menuPosW, menuPosH)
	StartButton:SetSize(100, 25)
	StartButton.OnClick = function(object)
		showPregame()
		sound_ButtonPress()
		print("PREGAME")
	end
	
	--Settings Button
	SettingsButton = loveframes.Create("imagebutton")
	SettingsButton:SetState("mainmenu")
	SettingsButton:SetImage(button_Image_Settings)
	SettingsButton:SetSize(100, 25)
	SettingsButton:SetPos(menuPosW, menuPosH+30)
	SettingsButton.OnClick = function(object)
		showSettings()
		sound_ButtonPress()
	end
	
	--About Button
	AboutButton = loveframes.Create("imagebutton")
	AboutButton:SetState("mainmenu")
	AboutButton:SetImage(button_Image_About)
	AboutButton:SetSize(100, 25)
	AboutButton:SetPos(menuPosW, menuPosH+60)
	AboutButton.OnClick = function(object)
		showCredits()
		sound_ButtonPress()
	end
	
	--Exit Button
	ExitButton = loveframes.Create("imagebutton")
	ExitButton:SetState("mainmenu")
	ExitButton:SetImage(button_Image_Exit)
	ExitButton:SetSize(100, 25)
	ExitButton:SetPos(menuPosW, menuPosH+90)
	ExitButton.OnClick = function(object)
		love.event.quit()
		sound_ButtonPress()
	end

------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------PreGame Window
------------------------------------------------------------------
------------------------------------------------------------------

	PreGameWindow = loveframes.Create("frame")
	PreGameWindow:SetName("Game Setup")
	PreGameWindow:SetState("pregame")
	PreGameWindow:SetSize(800, 640)
	PreGameWindow:SetPos((defaultResolutionW/2)-400, (defaultResolutionH/2)-320)
	PreGameWindow.OnClose = function(object)
		mainMenu()
		sound_ButtonPress()
	end

	CurrentMap = loveframes.Create("text", PreGameWindow)
	CurrentMap:SetPos(310, 30)
	CurrentMap:SetState("pregame")
	CurrentMap:SetText("Please Select a Map:")

	StartGame = loveframes.Create("button", PreGameWindow)
	StartGame:SetText("Start Game")
	StartGame:SetPos(5, 50)
	StartGame:SetState("pregame")
	StartGame:SetSize(300, 50)
	StartGame.OnClick = function(object)
		startGame()
		sound_ButtonPress()
	end

	--Here you can sellect the number of players
	NumberOfPlayers = loveframes.Create("button", PreGameWindow)
	NumberOfPlayers:SetText("Number of players :"..playerCount)
	NumberOfPlayers:SetPos(5, 110)
	NumberOfPlayers:SetState("pregame")
	NumberOfPlayers:SetSize(300, 50)
	NumberOfPlayers.OnClick = function (object)
		
		if(playerCount >= 4) then

			playerCount = 2
			NumberOfPlayers:SetText("Number of players :"..playerCount)

		elseif (playerCount >= 2) then

			playerCount = playerCount + 1
			NumberOfPlayers:SetText("Number of players :"..playerCount)

		end

		sound_ButtonPress()

	end

	--A list that holds all the maps located in assets/maps

	MapList = loveframes.Create("list", PreGameWindow)
	MapList:SetPos(310, 50)
	MapList:SetSize(480, 580)
	MapList:SetPadding(5)
	MapList:SetSpacing(10)
	MapList:SetState("pregame")

	--dir is where the files are located, k is just a counter, file is each of the files found on each loop.
	local function addMapButtons()

		dir = "assets/maps/"
		files = love.filesystem.getDirectoryItems(dir)

		for k, file in ipairs(files) do

	    	k = loveframes.Create("button")
	    	k:SetText(file)
	    	k:SetSize(180, 30)
	    	MapList:AddItem(k)
	    	k.OnClick = function(object) 

	    		map = (dir..removeFileExtension(file, ".lua"))
	    		defaultMap = map
	    		CurrentMap:SetText("Current Map: "..removeFileExtension(file, ".lua"))
				sound_ButtonPress()

	    	end

		end

	end
	addMapButtons()

	SkinText_Player1 = loveframes.Create("text", PreGameWindow)
	SkinText_Player1:SetPos(110, 180)
	SkinText_Player1:SetState("pregame")
	SkinText_Player1:SetText("Player 1 Skin:")

	SkinText_Player2 = loveframes.Create("text", PreGameWindow)
	SkinText_Player2:SetPos(110, 280)
	SkinText_Player2:SetState("pregame")
	SkinText_Player2:SetText("Player 2 Skin:")

	SkinText_Player3 = loveframes.Create("text", PreGameWindow)
	SkinText_Player3:SetPos(110, 380)
	SkinText_Player3:SetState("pregame")
	SkinText_Player3:SetText("Player 3 Skin:")

	SkinText_Player4 = loveframes.Create("text", PreGameWindow)
	SkinText_Player4:SetPos(110, 480)
	SkinText_Player4:SetState("pregame")
	SkinText_Player4:SetText("Player 4 Skin:")

	SkinButton_Player1 = loveframes.Create("imagebutton", PreGameWindow)
	SkinButton_Player1:SetState("pregame")
	SkinButton_Player1:SetImage(player_skins[player1IMG])
	SkinButton_Player1:SetPos(120, 200)
	SkinButton_Player1:SetSize(64, 64)
	SkinButton_Player1.OnClick = function(object)

		if player1IMG<skinCount then
			player1IMG = player1IMG + 1
		elseif player1IMG>=skinCount then
			player1IMG = 1
		end
		SkinButton_Player1:SetImage(player_skins[player1IMG])

	end

	SkinButton_Player2 = loveframes.Create("imagebutton", PreGameWindow)
	SkinButton_Player2:SetState("pregame")
	SkinButton_Player2:SetImage(player_skins[player2IMG])
	SkinButton_Player2:SetPos(120, 300)
	SkinButton_Player2:SetSize(64, 64)
	SkinButton_Player2.OnClick = function(object)

		if player2IMG<skinCount then
			player2IMG = player2IMG + 1
		elseif player2IMG>=skinCount then
			player2IMG = 1
		end
		SkinButton_Player2:SetImage(player_skins[player2IMG])

	end

	SkinButton_Player3 = loveframes.Create("imagebutton", PreGameWindow)
	SkinButton_Player3:SetState("pregame")
	SkinButton_Player3:SetImage(player_skins[player3IMG])
	SkinButton_Player3:SetPos(120, 400)
	SkinButton_Player3:SetSize(64, 64)
	SkinButton_Player3.OnClick = function(object)

		if player3IMG<skinCount then
			player3IMG = player3IMG + 1
		elseif player3IMG>=skinCount then
			player3IMG = 1
		end
		SkinButton_Player3:SetImage(player_skins[player3IMG])

	end

	SkinButton_Player4 = loveframes.Create("imagebutton", PreGameWindow)
	SkinButton_Player4:SetState("pregame")
	SkinButton_Player4:SetImage(player_skins[player4IMG])
	SkinButton_Player4:SetPos(120, 500)
	SkinButton_Player4:SetSize(64, 64)
	SkinButton_Player4.OnClick = function(object)

		if player4IMG<skinCount then
			player4IMG = player4IMG + 1
		elseif player4IMG>=skinCount then
			player4IMG = 1
		end
		SkinButton_Player4:SetImage(player_skins[player4IMG])

	end

	RoundLimit = loveframes.Create("button", PreGameWindow)
	RoundLimit:SetText("Round Limit : "..gameLength)
	RoundLimit:SetPos(5, 585)
	RoundLimit:SetState("pregame")
	RoundLimit:SetSize(300, 50)
	RoundLimit.OnClick = function(object)

		if gameLength<10 then
			gameLength = gameLength + 1
		elseif gameLength>=10 then
			gameLength = 1
		end

		RoundLimit:SetText("Round Limit : "..gameLength)

	end

------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------Settings Window
------------------------------------------------------------------
------------------------------------------------------------------
	
	--Make a shiny new window.
	SettingsWindow = loveframes.Create("frame")
	SettingsWindow:SetState("settings")
	SettingsWindow:SetName("Settings...")
	SettingsWindow:SetSize(800, 640)
	SettingsWindow:SetPos((defaultResolutionW/2)-400, (defaultResolutionH/2)-320)
	SettingsWindow.OnClose = function(object)
		mainMenu()
		sound_ButtonPress()
	end

	--Music Volume Text
	MusicVolumeText = loveframes.Create("text", SettingsWindow)
	MusicVolumeText:SetPos (50, 80)
    MusicVolumeText:SetText("Music Volume: "..(audioMusicVolume*100).."%")

	--Music Volume Slider
	MusicSlider = loveframes.Create("slider", SettingsWindow)
	MusicSlider:SetPos(50, 100)
	MusicSlider:SetWidth(300)
	MusicSlider:SetMinMax(0, 100)
	MusicSlider:SetDecimals(0)
	MusicSlider:SetValue(audioMusicVolume*100)
	MusicSlider.Update = function(object, dt)

    	audioMusicVolume = (MusicSlider:GetValue()/100)

    	MusicVolumeText:SetText("Music Volume: "..(audioMusicVolume*100).."%")

	end

	--Sound Effects Volume Text
	SFXVolumeText = loveframes.Create("text", SettingsWindow)
	SFXVolumeText:SetPos (50, 150)
    SFXVolumeText:SetText("Sound Effects Volume: "..(audioSFXVolume*100).."%")

	--Sound Effects Volume Slider
	SFXSlider = loveframes.Create("slider", SettingsWindow)
	SFXSlider:SetPos(50, 170)
	SFXSlider:SetWidth(300)
	SFXSlider:SetMinMax(0, 100)
	SFXSlider:SetDecimals(0)
	SFXSlider:SetValue(audioSFXVolume*100)
	SFXSlider.Update = function(object, dt)

    	audioSFXVolume = (SFXSlider:GetValue()/100)

    	SFXVolumeText:SetText("Sound Effects Volume: "..(audioSFXVolume*100).."%")

	end

	--Fullscreen Mode Checkbox
    Fullscreen = loveframes.Create("checkbox", SettingsWindow)
    Fullscreen:SetText("Fullscreen")
    Fullscreen:SetPos(50, 215)
    Fullscreen:SetChecked(false)
    if (graphicsFullscreen) then
    	Fullscreen:SetChecked(true)
	else
    	Fullscreen:SetChecked(false)		
    end

	--Borderless Mode Checkbox
    Borderless = loveframes.Create("checkbox", SettingsWindow)
    Borderless:SetText("Borderless")
    Borderless:SetPos(50, 250)
    if (graphicsBorderless) then
    	Borderless:SetChecked(true)
	else
    	Borderless:SetChecked(false)		
    end

	--Scaling Mode Checkbox
    Scaling = loveframes.Create("checkbox", SettingsWindow)
    Scaling:SetText("Scaling")
    Scaling:SetPos(50, 285)
    Scaling:SetChecked(false)
    if (graphicsScaling) then
    	Scaling:SetChecked(true)
	else
    	Scaling:SetChecked(false)		
    end

	--Developer Mode Checkbox
    Devmode = loveframes.Create("checkbox", SettingsWindow)
    Devmode:SetText("Developer Mode")
    Devmode:SetPos(50, 320)
    Devmode:SetChecked(false)
    if (developer) then
    	Devmode:SetChecked(true)
	else
    	Devmode:SetChecked(false)		
    end

	--Resolution Text
	ResolutioText = loveframes.Create("text", SettingsWindow)
	ResolutioText:SetPos (550, 75)
    ResolutioText:SetText("Change Resolution("..defaultResolutionW.."x"..defaultResolutionH..")")

    --Resolution Selection
	ResolutionHolder = loveframes.Create("list", SettingsWindow)
	ResolutionHolder:SetPos(550, 100)
	ResolutionHolder:SetSize(200, 200)
	ResolutionHolder:SetPadding(5)
	ResolutionHolder:SetSpacing(5)

	--Populate Resolution list
	local function addResolutions()
		
		for k, res in ipairs(resolutions) do

	    	k = loveframes.Create("button")
	    	k:SetText(tostring(res.X).."X"..tostring(res.Y))
	    	ResolutionHolder:AddItem(k)
	    	k.OnClick = function(object) 

				defaultResolutionW = res.X
				defaultResolutionH = res.Y

		        love.window.setMode(defaultResolutionW, defaultResolutionH, {borderless=graphicsBorderless})

		        graphicsFullscreen = false
		        Fullscreen:SetChecked(false)

		        showSettings()

		        ResolutioText:SetText("Change Resolution("..defaultResolutionW.."X"..defaultResolutionH..")")

				sound_ButtonPress()
		        
	    	end

		end

	end
	addResolutions()

	RebindsKeysButton = loveframes.Create("button",SettingsWindow)
	RebindsKeysButton:SetText("Rebind Controlls")
	RebindsKeysButton:SetPos(50,355)
	RebindsKeysButton:SetState("settings")
	RebindsKeysButton:SetSize(200, 30)
	RebindsKeysButton.OnClick = function(object)
		showRebinds()
	end

	--Apply Button
	ApplySettingsButton = loveframes.Create("button", SettingsWindow)
	ApplySettingsButton:SetState("settings")
	ApplySettingsButton:SetText("Apply Settings!")
	ApplySettingsButton:SetSize(700, 100)
	ApplySettingsButton:SetPos(50, 450)
	ApplySettingsButton.OnClick = function(object)

		print("APPLY SETTINGS!")
		
		sound_SetVolume()

		print("Changed Window Parameters")

        if (Fullscreen:GetChecked() == true) then

        	love.window.setMode(0, 0, {borderless=true})

            defaultResolutionW = love.graphics.getWidth( )
        	defaultResolutionH = love.graphics.getHeight( )

        	graphicsFullscreen = true
            graphicsBorderless = false
            
            Borderless:SetChecked(false)

    	elseif (Borderless:GetChecked() == true) then

            love.window.setMode(defaultResolutionW, defaultResolutionH, {borderless=true})

        	graphicsFullscreen = false
            graphicsBorderless = true

        	Fullscreen:SetChecked(false)

        elseif (Borderless:GetChecked() == false) and (Fullscreen:GetChecked() == false) then

            love.window.setMode(defaultResolutionW, defaultResolutionH, {borderless=false})

        	graphicsFullscreen = false
            graphicsBorderless = false

            Fullscreen:SetChecked(false)
            Borderless:SetChecked(false)

        end

        if (Scaling:GetChecked() == true) then
        	graphicsScaling = true
        elseif (Scaling:GetChecked() == false) then
        	graphicsScaling = false
        end

        if (Devmode:GetChecked() == true) then
        	developer = true
        elseif (Devmode:GetChecked() == false) then
        	developer = false
        end

        writeSettings(defaultResolutionW, defaultResolutionH, graphicsFullscreen, graphicsBorderless, graphicsScaling, audioMusicVolume, audioSFXVolume, true)

        mainMenu()

        ApplySettingsButton:SetText("SAVED!")
        countDown(2, function() ApplySettingsButton:SetText("APPLY SETTINGS!") end)

		sound_ButtonPress()

	end

------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------Rebind Screen
------------------------------------------------------------------
------------------------------------------------------------------
	RebindableWindow = loveframes.Create("frame")
	RebindableWindow:SetState("rebind")
	RebindableWindow:SetSize(400, 460)
	RebindableWindow:SetPos(defaultResolutionW/2-200, defaultResolutionH/2-230)
	RebindableWindow:SetName("Rebind Controlls")
    RebindableWindow.OnClose = function(object)
		showSettings()
	end

	Player1RebundFire = loveframes.Create("button", RebindableWindow)
	Player1RebundFire:SetSize(60, 40)
	Player1RebundFire:SetPos(10, 50)
	Player1RebundFire:SetText(player1Controls.Fire)
	Player1RebundFire:SetState("rebind")
	Player1RebundFire.OnClick = function(object)

		rebindTarget = player1Controls
		rebindControl = "Fire"
		rebindState = true
		Player1RebundFire:SetText("@")

	end

	Player1RebindUp = loveframes.Create("button", RebindableWindow)
	Player1RebindUp:SetSize(60, 40)
	Player1RebindUp:SetPos(220,50)
	Player1RebindUp:SetText(player1Controls.Up)
	Player1RebindUp:SetState("rebind")
	Player1RebindUp:SetEnabled(player1Keyboard)
	Player1RebindUp.OnClick = function(object)

		rebindTarget = player1Controls
		rebindControl = "Up"
		rebindState = true
		Player1RebindUp:SetText("@")

	end

	Player1RebindLeft = loveframes.Create("button", RebindableWindow)
	Player1RebindLeft:SetSize(60, 40)
	Player1RebindLeft:SetPos(160,90)
	Player1RebindLeft:SetText(player1Controls.Left)
	Player1RebindLeft:SetState("rebind")
	Player1RebindLeft:SetEnabled(player1Keyboard)
	Player1RebindLeft.OnClick = function(object)

		rebindTarget = player1Controls
		rebindControl = "Left"
		rebindState = true
		Player1RebindLeft:SetText("@")
		
	end

	Player1RebindDown = loveframes.Create("button", RebindableWindow)
	Player1RebindDown:SetSize(60, 40)
	Player1RebindDown:SetPos(220,90)
	Player1RebindDown:SetText(player1Controls.Down)
	Player1RebindDown:SetState("rebind")
	Player1RebindDown:SetEnabled(player1Keyboard)
	Player1RebindDown.OnClick = function(object)

		rebindTarget = player1Controls
		rebindControl = "Down"
		rebindState = true
		Player1RebindDown:SetText("@")

	end

	Player1RebindRight = loveframes.Create("button", RebindableWindow)
	Player1RebindRight:SetSize(60, 40)
	Player1RebindRight:SetPos(280,90)
	Player1RebindRight:SetText(player1Controls.Right)
	Player1RebindRight:SetState("rebind")
	Player1RebindRight:SetEnabled(player1Keyboard)
	Player1RebindRight.OnClick = function(object)

		rebindTarget = player1Controls
		rebindControl = "Right"
		rebindState = true
		Player1RebindRight:SetText("@")

	end

	Player1RebindController = loveframes.Create("button", RebindableWindow)
	Player1RebindController:SetText(player1Controls.Type)
	Player1RebindController:SetPos(10,90)
	Player1RebindController:SetSize(140,40)
	Player1RebindController:SetState("rebind")
	if connectedControllerCount > 0 then
		Player1RebindController:SetEnabled(true)
	else
		Player1RebindController:SetEnabled(false)
	end
	Player1RebindController.OnClick = function(object)

		if(player1Controls.Type == "keyboard") then

			player1Controls.Type = "controller"
			player1Keyboard = false

			player1Controls.Up = "-Y"
			player1Controls.Down = "+Y"
			player1Controls.Left = "-X"
			player1Controls.Right = "+X"
			player1Controls.Fire = "1"

		else

			player1Controls.Type = "keyboard"
			player1Keyboard = true

			player1Controls.Up = "w"
			player1Controls.Down = "s"
			player1Controls.Left = "a"
			player1Controls.Right = "d"
			player1Controls.Fire = "q"

		end

		Player1RebindUp:SetEnabled(player1Keyboard)
		Player1RebindDown:SetEnabled(player1Keyboard)
		Player1RebindLeft:SetEnabled(player1Keyboard)
		Player1RebindRight:SetEnabled(player1Keyboard)

		Player1RebindUp:SetText(player1Controls.Up)
		Player1RebindDown:SetText(player1Controls.Down)
		Player1RebindLeft:SetText(player1Controls.Left)
		Player1RebindRight:SetText(player1Controls.Right)
		Player1RebundFire:SetText(player1Controls.Fire)

		Player1RebindController:SetText(player1Controls.Type)

	end

	--PLAYER 2 REBIND BUTTONS
	Player2RebundFire = loveframes.Create("button", RebindableWindow)
	Player2RebundFire:SetSize(60, 40)
	Player2RebundFire:SetPos(10, 150)
	Player2RebundFire:SetText(player2Controls.Fire)
	Player2RebundFire:SetState("rebind")
	Player2RebundFire.OnClick = function(object)

		rebindTarget = player2Controls
		rebindControl = "Fire"
		rebindState = true
		Player2RebundFire:SetText("@")

	end

	Player2RebindUp = loveframes.Create("button", RebindableWindow)
	Player2RebindUp:SetSize(60, 40)
	Player2RebindUp:SetPos(220,150)
	Player2RebindUp:SetText(player2Controls.Up)
	Player2RebindUp:SetState("rebind")
	Player2RebindUp:SetEnabled(player2Keyboard)
	Player2RebindUp.OnClick = function(object)

		rebindTarget = player2Controls
		rebindControl = "Up"
		rebindState = true
		Player2RebindUp:SetText("@")

	end

	Player2RebindLeft = loveframes.Create("button", RebindableWindow)
	Player2RebindLeft:SetSize(60, 40)
	Player2RebindLeft:SetPos(160,190)
	Player2RebindLeft:SetText(player2Controls.Left)
	Player2RebindLeft:SetState("rebind")
	Player2RebindLeft:SetEnabled(player2Keyboard)
	Player2RebindLeft.OnClick = function(object)

		rebindTarget = player2Controls
		rebindControl = "Left"
		rebindState = true
		Player2RebindLeft:SetText("@")

	end

	Player2RebindDown = loveframes.Create("button", RebindableWindow)
	Player2RebindDown:SetSize(60, 40)
	Player2RebindDown:SetPos(220,190)
	Player2RebindDown:SetText(player2Controls.Down)
	Player2RebindDown:SetState("rebind")
	Player2RebindDown:SetEnabled(player2Keyboard)
	Player2RebindDown.OnClick = function(object)

		rebindTarget = player2Controls
		rebindControl = "Down"
		rebindState = true
		Player2RebindDown:SetText("@")

	end

	Player2RebindRight = loveframes.Create("button", RebindableWindow)
	Player2RebindRight:SetSize(60, 40)
	Player2RebindRight:SetPos(280,190)
	Player2RebindRight:SetText(player2Controls.Right)
	Player2RebindRight:SetState("rebind")
	Player2RebindRight:SetEnabled(player2Keyboard)
	Player2RebindRight.OnClick = function(object)

		rebindTarget = player2Controls
		rebindControl = "Right"
		rebindState = true
		Player2RebindRight:SetText("@")

	end

	Player2RebindController = loveframes.Create("button", RebindableWindow)
	Player2RebindController:SetText(player2Controls.Type)
	Player2RebindController:SetPos(10,190)
	Player2RebindController:SetSize(140,40)
	Player2RebindController:SetState("rebind")
	if connectedControllerCount > 1 then
		Player2RebindController:SetEnabled(true)
	else
		Player2RebindController:SetEnabled(false)
	end
	Player2RebindController.OnClick = function(object)

		if(player2Controls.Type == "keyboard") then

			player2Controls.Type = "controller"
			player2Keyboard = false

			player2Controls.Up = "-Y"
			player2Controls.Down = "+Y"
			player2Controls.Left = "-X"
			player2Controls.Right = "+X"
			player2Controls.Fire = "1"

		else

			player2Controls.Type = "keyboard"
			player2Keyboard = true

			player2Controls.Up = "up"
			player2Controls.Down = "down"
			player2Controls.Left = "left"
			player2Controls.Right = "right"
			player2Controls.Fire = "end"

		end

		Player2RebindUp:SetEnabled(player2Keyboard)
		Player2RebindDown:SetEnabled(player2Keyboard)
		Player2RebindLeft:SetEnabled(player2Keyboard)
		Player2RebindRight:SetEnabled(player2Keyboard)

		Player2RebindUp:SetText(player2Controls.Up)
		Player2RebindDown:SetText(player2Controls.Down)
		Player2RebindLeft:SetText(player2Controls.Left)
		Player2RebindRight:SetText(player2Controls.Right)
		Player2RebundFire:SetText(player2Controls.Fire)

		Player2RebindController:SetText(player2Controls.Type)

	end

	--PLAYER 3 REBIND BUTTONS
	Player3RebundFire = loveframes.Create("button", RebindableWindow)
	Player3RebundFire:SetSize(60, 40)
	Player3RebundFire:SetPos(10, 250)
	Player3RebundFire:SetText(player3Controls.Fire)
	Player3RebundFire:SetState("rebind")
	Player3RebundFire.OnClick = function(object)

		rebindTarget = player3Controls
		rebindControl = "Fire"
		rebindState = true
		Player3RebundFire:SetText("@")

	end

	Player3RebindUp = loveframes.Create("button", RebindableWindow)
	Player3RebindUp:SetSize(60, 40)
	Player3RebindUp:SetPos(220,250)
	Player3RebindUp:SetText(player3Controls.Up)
	Player3RebindUp:SetState("rebind")
	Player3RebindUp:SetEnabled(player3Keyboard)
	Player3RebindUp.OnClick = function(object)

		rebindTarget = player3Controls
		rebindControl = "Up"
		rebindState = true
		Player3RebindUp:SetText("@")

	end

	Player3RebindLeft = loveframes.Create("button", RebindableWindow)
	Player3RebindLeft:SetSize(60, 40)
	Player3RebindLeft:SetPos(160,290)
	Player3RebindLeft:SetText(player3Controls.Left)
	Player3RebindLeft:SetState("rebind")
	Player3RebindLeft:SetEnabled(player3Keyboard)
	Player3RebindLeft.OnClick = function(object)

		rebindTarget = player3Controls
		rebindControl = "Left"
		rebindState = true
		Player3RebindLeft:SetText("@")

	end

	Player3RebindDown = loveframes.Create("button", RebindableWindow)
	Player3RebindDown:SetSize(60, 40)
	Player3RebindDown:SetPos(220,290)
	Player3RebindDown:SetText(player3Controls.Down)
	Player3RebindDown:SetState("rebind")
	Player3RebindDown:SetEnabled(player3Keyboard)
	Player3RebindDown.OnClick = function(object)

		rebindTarget = player3Controls
		rebindControl = "Down"
		rebindState = true
		Player3RebindDown:SetText("@")

	end

	Player3RebindRight = loveframes.Create("button", RebindableWindow)
	Player3RebindRight:SetSize(60, 40)
	Player3RebindRight:SetPos(280,290)
	Player3RebindRight:SetText(player3Controls.Right)
	Player3RebindRight:SetState("rebind")
	Player3RebindRight:SetEnabled(player3Keyboard)
	Player3RebindRight.OnClick = function(object)

		rebindTarget = player3Controls
		rebindControl = "Right"
		rebindState = true
		Player3RebindRight:SetText("@")

	end

	Player3RebindController = loveframes.Create("button", RebindableWindow)
	Player3RebindController:SetText(player3Controls.Type)
	Player3RebindController:SetPos(10,290)
	Player3RebindController:SetSize(140,40)
	Player3RebindController:SetState("rebind")
	if connectedControllerCount > 2 then
		Player3RebindController:SetEnabled(true)
	else
		Player3RebindController:SetEnabled(false)
	end
	Player3RebindController.OnClick = function(object)

		if(player3Controls.Type == "keyboard") then

			player3Controls.Type = "controller"
			player3Keyboard = false

			player3Controls.Up = "-Y"
			player3Controls.Down = "+Y"
			player3Controls.Left = "-X"
			player3Controls.Right = "+X"
			player3Controls.Fire = "1"

		else

			player3Controls.Type = "keyboard"
			player3Keyboard = true

			player3Controls.Up = "kp8"
			player3Controls.Down = "kp5"
			player3Controls.Left = "kp4"
			player3Controls.Right = "kp6"
			player3Controls.Fire = "kp0"

		end

		Player3RebindUp:SetEnabled(player3Keyboard)
		Player3RebindDown:SetEnabled(player3Keyboard)
		Player3RebindLeft:SetEnabled(player3Keyboard)
		Player3RebindRight:SetEnabled(player3Keyboard)

		Player3RebindUp:SetText(player3Controls.Up)
		Player3RebindDown:SetText(player3Controls.Down)
		Player3RebindLeft:SetText(player3Controls.Left)
		Player3RebindRight:SetText(player3Controls.Right)
		Player3RebundFire:SetText(player3Controls.Fire)

		Player3RebindController:SetText(player3Controls.Type)

	end

	--PLAYER 4 REBIND BUTTONS
	Player4RebundFire = loveframes.Create("button", RebindableWindow)
	Player4RebundFire:SetSize(60, 40)
	Player4RebundFire:SetPos(10, 350)
	Player4RebundFire:SetText(player4Controls.Fire)
	Player4RebundFire:SetState("rebind")
	Player4RebundFire.OnClick = function(object)

		rebindTarget = player4Controls
		rebindControl = "Fire"
		rebindState = true
		Player4RebundFire:SetText("@")

	end

	Player4RebindUp = loveframes.Create("button", RebindableWindow)
	Player4RebindUp:SetSize(60, 40)
	Player4RebindUp:SetPos(220,350)
	Player4RebindUp:SetText(player4Controls.Up)
	Player4RebindUp:SetState("rebind")
	Player4RebindUp:SetEnabled(player4Keyboard)
	Player4RebindUp.OnClick = function(object)

		rebindTarget = player4Controls
		rebindControl = "Up"
		rebindState = true
		Player4RebindUp:SetText("@")

	end

	Player4RebindLeft = loveframes.Create("button", RebindableWindow)
	Player4RebindLeft:SetSize(60, 40)
	Player4RebindLeft:SetPos(160,390)
	Player4RebindLeft:SetText(player4Controls.Left)
	Player4RebindLeft:SetState("rebind")
	Player4RebindLeft:SetEnabled(player4Keyboard)
	Player4RebindLeft.OnClick = function(object)

		rebindTarget = player4Controls
		rebindControl = "Left"
		rebindState = true
		Player4RebindLeft:SetText("@")

	end

	Player4RebindDown = loveframes.Create("button", RebindableWindow)
	Player4RebindDown:SetSize(60, 40)
	Player4RebindDown:SetPos(220,390)
	Player4RebindDown:SetText(player4Controls.Down)
	Player4RebindDown:SetState("rebind")
	Player4RebindDown:SetEnabled(player4Keyboard)
	Player4RebindDown.OnClick = function(object)

		rebindTarget = player4Controls
		rebindControl = "Down"
		rebindState = true
		Player4RebindDown:SetText("@")
		

	end

	Player4RebindRight = loveframes.Create("button", RebindableWindow)
	Player4RebindRight:SetSize(60, 40)
	Player4RebindRight:SetPos(280,390)
	Player4RebindRight:SetText(player4Controls.Right)
	Player4RebindRight:SetState("rebind")
	Player4RebindRight:SetEnabled(player4Keyboard)
	Player4RebindRight.OnClick = function(object)

		rebindTarget = player4Controls
		rebindControl = "Right"
		rebindState = true
		Player4RebindRight:SetText("@")
		
	end

	Player4RebindController = loveframes.Create("button", RebindableWindow)
	Player4RebindController:SetText(player4Controls.Type)
	Player4RebindController:SetPos(10,390)
	Player4RebindController:SetSize(140,40)
	Player4RebindController:SetState("rebind")
	if connectedControllerCount > 2 then
		Player4RebindController:SetEnabled(true)
	else
		Player4RebindController:SetEnabled(false)
	end
	Player4RebindController.OnClick = function(object)

		if(player4Controls.Type == "keyboard") then

			player4Controls.Type = "controller"
			player4Keyboard = false

			player4Controls.Up = "-Y"
			player4Controls.Down = "+Y"
			player4Controls.Left = "-X"
			player4Controls.Right = "+X"
			player4Controls.Fire = "1"

		else

			player4Controls.Type = "keyboard"
			player4Keyboard = true

			player4Controls.Up = "u"
			player4Controls.Down = "j"
			player4Controls.Left = "h"
			player4Controls.Right = "k"
			player4Controls.Fire = "i"

		end

		Player4RebindUp:SetEnabled(player4Keyboard)
		Player4RebindDown:SetEnabled(player4Keyboard)
		Player4RebindLeft:SetEnabled(player4Keyboard)
		Player4RebindRight:SetEnabled(player4Keyboard)

		Player4RebindUp:SetText(player4Controls.Up)
		Player4RebindDown:SetText(player4Controls.Down)
		Player4RebindLeft:SetText(player4Controls.Left)
		Player4RebindRight:SetText(player4Controls.Right)
		Player4RebundFire:SetText(player4Controls.Fire)

		Player4RebindController:SetText(player4Controls.Type)

	end

------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------Credits Screen
------------------------------------------------------------------
------------------------------------------------------------------

	--Make a shiny new window.
	AboutUsWindow = loveframes.Create("frame")
	AboutUsWindow:SetState("credits")
	AboutUsWindow:SetName("About us...")
	AboutUsWindow:SetSize(800, 600)
	AboutUsWindow:SetPos((defaultResolutionW/2)-400, (defaultResolutionH/2)-300)
	AboutUsWindow.OnClose = function(object)
		loveframes.SetState("mainmenu")
		sound_ButtonPress()
	end
	
	--Credits Text
	AboutUsText = loveframes.Create("text", AboutUsWindow)
    AboutUsText:SetLinksEnabled(true)
	AboutUsText:SetDetectLinks(true)
	AboutUsText:SetShadow(true)
	AboutUsText:SetMaxWidth(500)
	AboutUsText:SetShadowColor(200, 200, 200, 255)
	AboutUsText:SetPos (50, 30)
    AboutUsText:SetText("Lead Programming and Project Management by Berk \"SAS41\" Alyamach\n".."Co-Programming by Daniel \"XepouH\" Angelov\n".."Art by Georgi \"Jinxed\" Trifonov\n".."Map Design by Gabriel \"Eljudni\" Keremidchieva\n".."Music by Kevin MacLeod and Georgi \"Jinxed\" Trifonov")

------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------Ingame Menu
------------------------------------------------------------------
------------------------------------------------------------------

	--Resume Button
	InGameResumeButton = loveframes.Create("imagebutton")
	InGameResumeButton:SetState("ingamemenu")
	InGameResumeButton:SetImage(button_Image_Resume)
	InGameResumeButton:SetPos(menuPosW, menuPosH)
	InGameResumeButton:SetSize(100, 25)
	InGameResumeButton.OnClick = function(object)
		gamePaused = false
		loveframes.SetState("none")
		sound_ButtonPress()
	end
	
	--IngameExit Button
	InGameExitButton = loveframes.Create("imagebutton")
	InGameExitButton:SetState("ingamemenu")
	InGameExitButton:SetImage(button_Image_Exit)
	InGameExitButton:SetSize(100, 25)
	InGameExitButton:SetPos(menuPosW, menuPosH+30)
	InGameExitButton.OnClick = function(object)
		love.event.quit()
		sound_ButtonPress()
	end

end

function resetMenus()

	menuPosW = (defaultResolutionW/2)-50
	menuPosH = 200

	StartButton:Remove()
	SettingsButton:Remove()
	AboutButton:Remove()
	ExitButton:Remove()

	PreGameWindow:Remove()

	SettingsWindow:Remove()

	RebindableWindow:Remove()

	AboutUsWindow:Remove()

	InGameResumeButton:Remove()
	InGameExitButton:Remove()

	createAllUIElements()

end

function mainMenu()
	resetMenus()
	loveframes.SetState("mainmenu")
end

function showPregame()
	resetMenus()
	loveframes.SetState("pregame")
end

function showSettings()
	resetMenus()
	loveframes.SetState("settings")
end


function showRebinds()
	resetMenus()
	loveframes.SetState("rebind")
end

function showCredits()

	resetMenus()
	loveframes.SetState("credits")
	
end

function inGameMenu()

	if gameOn == true and gamePaused == false then

		gamePaused = true
		resetMenus()
		loveframes.SetState("ingamemenu")

	end

end