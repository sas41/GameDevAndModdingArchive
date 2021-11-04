--
--Player Object
--
function playerInit()

	spriteLayer = map.layers["Sprite Layer"]

	playerMovement = "idle"
	playerSide = "right"
	playerIsShooting = false
	playerIsJumping = false
	playerIsDown = false
	playerDirectionVertical		= "m"
	playerDirectionHorizontal	= "r"

	spriteLayer.player = {
	x = 200,
	y = 200,
	ammo = "normal",
	}

	spriteLayer.player.body 	= love.physics.newBody(world, spriteLayer.player.x, spriteLayer.player.y, "dynamic")
	spriteLayer.player.shape	= love.physics.newRectangleShape(42, 92)
	spriteLayer.player.fixture	= love.physics.newFixture(spriteLayer.player.body, spriteLayer.player.shape, 0)

	spriteLayer.player.body:setLinearDamping(0)
	spriteLayer.player.body:setFixedRotation(true)
	
	spriteLayer.player.fixture:setUserData("Player")

	--
	--Cache animations
	--

	--Standing Animation
	animation_player_idle_right = newAnimation(asset_player_sprite_idle_right, 100, 100, 0.5, 0)
	animation_player_idle_right:setMode("loop")
	animation_player_idle_left = newAnimation(asset_player_sprite_idle_left, 100, 100, 0.5, 0)
	animation_player_idle_left:setMode("loop")

	--Running Animations
	animation_player_running_right = newAnimation(asset_player_sprite_running_right, 100, 100, 0.1, 0)
	animation_player_running_right:setMode("loop")
	animation_player_running_left = newAnimation(asset_player_sprite_running_left, 100, 100, 0.1, 0)
	animation_player_running_left:setMode("loop")

	--Down Animations
	animation_player_down_right = newAnimation(asset_player_sprite_down_right, 130, 36, 1, 0)
	animation_player_down_right:setMode("loop")
	animation_player_down_left = newAnimation(asset_player_sprite_down_left, 130, 36, 1, 0)
	animation_player_down_left:setMode("loop")

	--Crawling Animations
	animation_player_crawling_right = newAnimation(asset_player_sprite_crawling_right, 130, 36, 1, 0)
	animation_player_crawling_right:setMode("loop")
	animation_player_crawling_left = newAnimation(asset_player_sprite_crawling_left, 130, 36, 1, 0)
	animation_player_crawling_left:setMode("loop")

end

--
--Player Movement
--
function movePlayer(direction)

	if direction == "right" then

		

	end

	if direction == "left" then

		

	end

	if direction == "up" then

		spriteLayer.player.body:applyLinearImpulse(0, -100)

	end

	if direction == "down" then

		spriteLayer.player.fixture:destroy()
		spriteLayer.player.shape	= love.physics.newRectangleShape(102, 38)
		spriteLayer.player.fixture	= love.physics.newFixture(spriteLayer.player.body, spriteLayer.player.shape, 0)

	end

	if direction == "standup" then

		spriteLayer.player.fixture:destroy()
		spriteLayer.player.shape	= love.physics.newRectangleShape(42, 92)
		spriteLayer.player.fixture	= love.physics.newFixture(spriteLayer.player.body, spriteLayer.player.shape, 0)

	end
	if direction == "stop" then

  		spriteLayer.player.body:setLinearVelocity( 0, 0 )

	end

end

function fireWeapon(direction, type)

	if direction == "u" then


	elseif direction == "d" then


	elseif direction == "l" then


	elseif direction == "r" then


	elseif direction == "ur" then


	elseif direction == "ul" then


	elseif direction == "dr" then


	elseif direction == "dl" then

	end

end

