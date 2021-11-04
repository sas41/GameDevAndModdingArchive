--Here we initiate a game
function startGame()

	gameStartState = true
	gameEndChecker = true

	sound_GameStart()

	countDown(1, function()
	gameStartState = false
	end)

	--Stop the UI
	loveframes.SetState("none")

	--Set the game on state to true
	gameOn = true

	--Load up our map.
	map = sti.new(defaultMap)

	--Set how many ingame pixels will be equal to 1 meter (Physics engine)
	love.physics.setMeter(16)

	--Create a physical world
	world = love.physics.newWorld(0*love.physics.getMeter(), 0*love.physics.getMeter())
	world:setCallbacks( beginContact, endContact, preSolve, postSolve )

	--Add in some collision
	collision = map:initWorldCollision(world)

	map:drawWorldCollision(collision)
	
    map:resize(defaultResolutionW*(3), defaultResolutionH*(3))

	placePlayers()

	initiatePlayers()

	destroyPowerUp()

	kickStartPowerUps()

end