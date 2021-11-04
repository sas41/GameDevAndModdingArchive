function startGame()

	startLevel()
	closeMainMenu()

	playerInit()

	gameIsOn = true

end

levels = {}

function loadLevels()

	table.insert(levels, {Name="Test Level", Height=1088, Width=1920})

end

function startLevel()

	map = sti.new("assets/maps/testmap")
	map:addCustomLayer("Sprite Layer", 3)
	love.window.setMode(1280, 720)
	map:resize(gameResW*10, gameResH*10)

	love.physics.setMeter(100)
	world = love.physics.newWorld(0*love.physics.getMeter(), 8*love.physics.getMeter())
	world:setCallbacks( beginContact, endContact, preSolve, postSolve )

	--Add in some collision
	collision = map:initWorldCollision(world)
	
	map:drawWorldCollision(collision)

end