--Set the name of the window
love.window.setTitle( "THROW ROCKS AT YOUR FRIENDS!" )
love.mouse.setVisible(false)

--Fonts
gameFont = love.graphics.newFont(12);
scoreFont = love.graphics.newFont("assets/fonts/MAGNETOB.ttf", 64);

--Set Local Graphics Parameters
defaultResolutionW = 800
defaultResolutionH = 640
graphicsScaling = true
graphicsFullscreen = false
graphicsBorderless = false

--Keep a variable for the state of the audio and volume of the game
audioMusicVolume = 1
audioSFXVolume = 1

--Create Scaling loop for the title image
titleScale = 0.5

--Keep information about the game state
gameOn = false
gamePaused = false
gameStartState = false
gameOverState = false
gameEndChecker = false
gameShowScoreBoard = false

--This is where the CountDownTimer keeps the information about events
eventKeeper	= {}

--Number of Players playing and if the game is over
playerCount		= 2
player1Active	= false
player2Active	= false
player3Active	= false
player4Active	= false

--Some variables for the game engine
world = nil
map = nil
collision = nil
spriteLayer = nil

--Default map is Debugging map
defaultMap = "assets/maps/map_test"

currentMapPath = nil
playerSpawns = {}
availableSpawnPoints = 0

--Set to Developer mode
developer = false

--Keep pre-set resolutions here
resolutions = {}
table.insert (resolutions, {X = 800, Y = 640})
table.insert (resolutions, {X = 1024, Y = 768})
table.insert (resolutions, {X = 1280, Y = 1024})
table.insert (resolutions, {X = 1280, Y = 720})
table.insert (resolutions, {X = 1366, Y = 768})
table.insert (resolutions, {X = 1920, Y = 1080})

--Joysticks
connectedControllerCount = 0
connectedContollers = love.joystick.getJoysticks()

for i in ipairs(connectedContollers) do
	connectedControllerCount = connectedControllerCount + 1
end

--Map size information
mapSizeX		= 1920
mapSizeY		= 1088

gameLength = 1
score_Player1 = 0
score_Player2 = 0
score_Player3 = 0
score_Player4 = 0