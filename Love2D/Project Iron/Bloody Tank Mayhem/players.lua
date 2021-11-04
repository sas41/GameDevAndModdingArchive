player1IMG = 1
player2IMG = 3
player3IMG = 5
player4IMG = 7

playerShapeX	= 64
playerShapeY	= 64
playerDamping	= 10

player1_StartPosX	= 105
player1_StartPosY	= 105
player1_Rotation	= 0

player2_StartPosX	= 700
player2_StartPosY	= 105
player2_Rotation	= 0

player3_StartPosX	= 105
player3_StartPosY	= 540
player3_Rotation	= 0

player4_StartPosX	= 700
player4_StartPosY	= 540
player4_Rotation	= 0


function initiatePlayers()

	if	playerCount > 0 then player1Active = true else player1Active = false end
	if	playerCount > 1 then player2Active = true else player2Active = false end
	if	playerCount > 2 then player3Active = true else player3Active = false end
	if	playerCount > 3 then player4Active = true else player4Active = false end

	-- Add a Custom Layer
	map:addCustomLayer("Sprite Layer", 3)

	spriteLayer = map.layers["Sprite Layer"]

	if player1Active == true then

		-- Add Custom Data
		spriteLayer.player1 = {
		image = player_skins[player1IMG],
		x = player1_StartPosX,
		y = player1_StartPosY,
		r = player1_Rotation,
		aimPosX = 0,
		aimPosY = -76,
		refire = math.floor(love.timer.getTime( )) +2,
		ammo = "normal",
		}

		spriteLayer.player1.body	= love.physics.newBody(world, spriteLayer.player1.x, spriteLayer.player1.y, "dynamic")
		spriteLayer.player1.shape	= love.physics.newRectangleShape(playerShapeX, playerShapeY)
		spriteLayer.player1.fixture	= love.physics.newFixture(spriteLayer.player1.body, spriteLayer.player1.shape)

		spriteLayer.player1.point	= love.physics.newRectangleShape(0, -12,6, 6)
		spriteLayer.player1.pointFixture	= love.physics.newFixture(spriteLayer.player1.body, spriteLayer.player1.point)

		spriteLayer.player1.body:setAngle( spriteLayer.player1.r )
		spriteLayer.player1.body:setFixedRotation( true )
		spriteLayer.player1.body:setLinearDamping(10)
		
		spriteLayer.player1.fixture:setUserData("Player") 


	end

	if player2Active == true then

		-- Add Custom Data
		spriteLayer.player2 = {
		image = player_skins[player2IMG],
		x = player2_StartPosX,
		y = player2_StartPosY,
		r = player2_Rotation,
		aimPosX = 0,
		aimPosY = -76,
		refire = math.floor(love.timer.getTime( )) +2,
		ammo = "normal",
		}

		spriteLayer.player2.body	= love.physics.newBody(world, spriteLayer.player2.x, spriteLayer.player2.y, "dynamic")
		spriteLayer.player2.shape	= love.physics.newRectangleShape(playerShapeX, playerShapeY)
		spriteLayer.player2.fixture	= love.physics.newFixture(spriteLayer.player2.body, spriteLayer.player2.shape)
		
		spriteLayer.player2.point	= love.physics.newRectangleShape(0, -12, 6, 6)
		spriteLayer.player2.pointFixture	= love.physics.newFixture(spriteLayer.player2.body, spriteLayer.player2.point)

		spriteLayer.player2.body:setAngle( spriteLayer.player2.r )
		spriteLayer.player2.body:setFixedRotation( true )
		spriteLayer.player2.body:setLinearDamping(10)
		
		spriteLayer.player2.fixture:setUserData("Player") 

	end

	if player3Active == true then

		-- Add Custom Data
		spriteLayer.player3 = {
		image = player_skins[player3IMG],
		x = player3_StartPosX,
		y = player3_StartPosY,
		r = player3_Rotation,
		aimPosX = 0,
		aimPosY = -76,
		refire = math.floor(love.timer.getTime( )) +2,
		ammo = "normal",
		}

		spriteLayer.player3.body	= love.physics.newBody(world, spriteLayer.player3.x, spriteLayer.player3.y, "dynamic")
		spriteLayer.player3.shape	= love.physics.newRectangleShape(playerShapeX, playerShapeY)
		spriteLayer.player3.fixture	= love.physics.newFixture(spriteLayer.player3.body, spriteLayer.player3.shape)

		spriteLayer.player3.point	= love.physics.newRectangleShape(0, -12, 6, 6)
		spriteLayer.player3.fixture2	= love.physics.newFixture(spriteLayer.player3.body, spriteLayer.player3.point)

		spriteLayer.player3.body:setAngle( spriteLayer.player3.r )
		spriteLayer.player3.body:setFixedRotation( true )
		spriteLayer.player3.body:setLinearDamping(10)
		
		spriteLayer.player3.fixture:setUserData("Player") 

	end

	if player4Active == true then

		-- Add Custom Data
		spriteLayer.player4 = {
		image = player_skins[player4IMG],
		x = player4_StartPosX,
		y = player4_StartPosY,
		r = player4_Rotation,
		aimPosX = 0,
		aimPosY = -76,
		refire = math.floor(love.timer.getTime( )) +2,
		ammo = "normal",
		}

		spriteLayer.player4.body	= love.physics.newBody(world, spriteLayer.player4.x, spriteLayer.player4.y, "dynamic")
		spriteLayer.player4.shape	= love.physics.newRectangleShape(playerShapeX, playerShapeY)
		spriteLayer.player4.fixture	= love.physics.newFixture(spriteLayer.player4.body, spriteLayer.player4.shape)

		spriteLayer.player4.point	= love.physics.newRectangleShape(0, -12, 6, 6)
		spriteLayer.player4.fixture2	= love.physics.newFixture(spriteLayer.player4.body, spriteLayer.player4.point)

		spriteLayer.player4.body:setAngle( spriteLayer.player4.r )
		spriteLayer.player4.body:setFixedRotation( true )
		spriteLayer.player4.body:setLinearDamping(10)

		spriteLayer.player4.fixture:setUserData("Player") 
		
	end

	-- Override Update callback
	function spriteLayer:update(dt)

	end

	-- Override Draw callback
	function spriteLayer:draw()

		drawIngameElements()

	end

end

--This will update the player position to ensure that the sprites match the hit boxes
function updatePlayers()

	local function updateSprite(currentPlayer, currentSprite)

		currentSprite.x, currentSprite.y = currentPlayer.body:getWorldCenter()

	end

	if player1Active == true then updateSprite(spriteLayer.player1, map.layers["Sprite Layer"].player1) end
	if player2Active == true then updateSprite(spriteLayer.player2, map.layers["Sprite Layer"].player2) end
	if player3Active == true then updateSprite(spriteLayer.player3, map.layers["Sprite Layer"].player3) end
	if player4Active == true then updateSprite(spriteLayer.player4, map.layers["Sprite Layer"].player4) end

end

--Debugging functionality is available below
function debugPlayers(object)

	local function doDebug(player)

		local currentPlayer	= nil

		if player==1 then
			currentPlayer	= map.layers["Sprite Layer"].player1
		elseif player==2 then
			currentPlayer	= map.layers["Sprite Layer"].player2
		elseif player==3 then
			currentPlayer	= map.layers["Sprite Layer"].player3
		elseif player==4 then
			currentPlayer	= map.layers["Sprite Layer"].player4
		end

		love.graphics.setColor(255, 255, 0, 255)

		if object == "physics" then
			love.graphics.polygon("line", currentPlayer.body:getWorldPoints(currentPlayer.shape:getPoints()))
			love.graphics.polygon("line", currentPlayer.body:getWorldPoints(currentPlayer.point:getPoints()))
		else
			local xCor, yCor = currentPlayer.body:getPosition()
			love.graphics.print("X = "..tostring((math.floor(xCor+0.5))).." Y = "..tostring((math.floor(yCor+0.5))), 10, (10*player)+20)
		end
		
		love.graphics.setColor(255, 255, 255, 255)

	end

	if player1Active == true then
		doDebug(1)
	end
	if player2Active == true then
		doDebug(2)
	end
	if player3Active == true then
		doDebug(3)
	end
	if player4Active == true then
		doDebug(4)
	end

end