powerUpPresent = false

powerUpCount = 2
powerUpTypes = {}
table.insert(powerUpTypes, "bomb")
table.insert(powerUpTypes, "ghost")

powerUpSpawnCount = 0
powerUpSpawns = {}

countdownRespawnTime = 30

function randomPowerUp()

	local randomizer = math.random(1, powerUpCount)
	local randomPosition = math.random(1, powerUpSpawnCount)
	createPowerUp(powerUpTypes[randomizer], powerUpSpawns[randomPosition].x, powerUpSpawns[randomPosition].y)

	countDown(countdownRespawnTime, function()
		if gameOn == true then
			destroyPowerUp()
			randomPowerUp()
		end
	end)

end

function createPowerUp(powerUpType,powerUpX, powerUpY)

	local powerUpSize = 64

	currentPowerUp = {
	image = powerUpBox,
	x = powerUpX,
	y = powerUpY,
	type = powerUpType,
	}

	currentPowerUp.body	= love.physics.newBody(world, currentPowerUp.x, currentPowerUp.y, "dynamic")
	currentPowerUp.shape	= love.physics.newRectangleShape(powerUpSize, powerUpSize)
	currentPowerUp.fixture	= love.physics.newFixture(currentPowerUp.body, currentPowerUp.shape)

	currentPowerUp.body:setFixedRotation( true )
	currentPowerUp.body:setLinearDamping(0)
	
	currentPowerUp.fixture:setUserData("PowerUp_"..powerUpType)

	powerUpPresent = true

end

function destroyPowerUp()
	if powerUpPresent then
		currentPowerUp.body:destroy()
		powerUpPresent = false
	end
end

function drawPowerUp()
	if powerUpPresent then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(currentPowerUp.image, currentPowerUp.body:getX()-32, currentPowerUp.body:getY()-32)
	end
end

function calculatePowerUpPositions()

	powerUpSpawnCount = 0

	for i,v in ipairs(powerUpSpawns) do
		table.remove(powerUpSpawns, i)
	end

	for i,v in ipairs(map.layers.powerups.objects) do

		table.insert(powerUpSpawns, {x = v.x, y = v.y})
		powerUpSpawnCount = powerUpSpawnCount + 1

	end

end

function kickStartPowerUps()
	calculatePowerUpPositions()
	randomPowerUp()
end

function handlePowerUpCollision(object)

end