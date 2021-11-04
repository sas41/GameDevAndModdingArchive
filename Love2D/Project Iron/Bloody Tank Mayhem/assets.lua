--Crosshair
crosshairImage	= love.graphics.newImage("assets/sprites/misc/crosshair.png")
	
--Backgrounds
backgroundImage	= love.graphics.newImage("assets/design/MainMenuBG.png")
endScreenImage	= love.graphics.newImage("assets/design/EndScreen.png")

--Texts
titleImage		= love.graphics.newImage("assets/design/TitleText.png")

--Buttons
button_Image_Start		= "assets/design/start.png"
button_Image_Resume		= "assets/design/resume.png"
button_Image_Settings	= "assets/design/settings.png"
button_Image_About		= "assets/design/about.png"
button_Image_Exit		= "assets/design/exit.png"

--Player Sprites
player_skins = {}
skinCount = 0
function loadPlayerSprites()

	local dir = "assets/sprites/players/"
	local files = love.filesystem.getDirectoryItems(dir)

	for i, file in ipairs(files) do

		table.insert(player_skins, dir..file)
		skinCount = skinCount + 1

	end

end

--Bullets Sprites
bullet_Image_Big 		= love.graphics.newImage("assets/sprites/projectiles/bullet_big.png")
bullet_Image_Small		= love.graphics.newImage("assets/sprites/projectiles/bullet_small.png")
bullet_Image_Bomb		= love.graphics.newImage("assets/sprites/projectiles/bullet_big.png")

--Music
soundAsset_mainMenuMusc = "assets/music/Ice Flow.mp3"

soundAsset_ingameMusic = {}
musicCount = 0
function addSongs()

	local dir = "assets/music/"
	local files = love.filesystem.getDirectoryItems(dir)

	for i, file in ipairs(files) do

		table.insert(soundAsset_ingameMusic, dir..file)
		musicCount = musicCount + 1

	end

end

--Sounds
soundAsset_countDown	= "assets/sounds/countdown.mp3"
soundAsset_buttonPress	= "assets/sounds/button.mp3"
soundAsset_tankFire		= ""

--Maps
maps = {}
mapCount = 0
function addMaps()

	local dir = "assets/maps/"
	local files = love.filesystem.getDirectoryItems(dir)

	for k, file in ipairs(files) do

		local map = (dir..removeFileExtension(file, ".lua"))
		table.insert(maps, map)
		mapCount = mapCount + 1

	end

end

------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------

--Animated Sprites
sprite_Explosion = love.graphics.newImage("assets/sprites/effects/explosion.png")

--PowerUps
powerUpBox	= love.graphics.newImage("assets/sprites/misc/powerup.png")
pickupBomb	= love.graphics.newImage("assets/sprites/misc/powerup_bomb.png")
pickupGhost	= love.graphics.newImage("assets/sprites/misc/powerup_ghost.png")