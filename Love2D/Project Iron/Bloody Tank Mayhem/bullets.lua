--Some info about the bullets
bulletBig_radius			= 6
bulletSmall_radius			= 3

objectMultiplier			= 40
bullet_NormalLifeSpan		= 4
bullet_BombLifeSpan			= 3
bullet_SmallLifeSpan		= 3

reloadTime = 2

--Set Bullets' Table
bullets_normal = {}
bullets_bomb = {}
bullets_small = {}
bullets_ghost = {}

function fireBullet(type, startX, startY, newAimPosX, newAimPosY, world)

	if type == "normal" then
		
		local body 			= love.physics.newBody(world, (startX+newAimPosX*objectMultiplier), (startY-newAimPosY*objectMultiplier), "dynamic")
		local bulletShape 	= love.physics.newCircleShape( bulletBig_radius )
		local fixture 		= love.physics.newFixture(body, bulletShape)
		local creation_time = love.timer.getTime()
		local bulletSpeed 	= 240

		fixture:setRestitution(1)
		body:setLinearDamping(0)
			
		fixture:setUserData("Bullet_Norm"..tostring(creation_time))

		body:applyLinearImpulse(newAimPosX*bulletSpeed, newAimPosY*-bulletSpeed)
		body:setBullet(true) 

		table.insert(bullets_normal, {fixture = fixture, body = body, creation_time = creation_time})

	elseif type == "small" then
		
		local body 			= love.physics.newBody(world, (startX+newAimPosX), (startY-newAimPosY), "dynamic")
		local bulletShape 	= love.physics.newCircleShape( bulletSmall_radius )
		local fixture 		= love.physics.newFixture(body, bulletShape)
		local creation_time = love.timer.getTime()
		local bulletSpeed 	= 150

		fixture:setRestitution(1)
		body:setLinearDamping(0)
			
		fixture:setUserData("Bullet_Smal"..tostring(creation_time))

		body:applyLinearImpulse(newAimPosX*bulletSpeed, newAimPosY*-bulletSpeed)
		body:setBullet(true) 

		table.insert(bullets_small, {fixture = fixture, body = body, creation_time = creation_time})

	elseif type == "bomb" then

		local body 			= love.physics.newBody(world, (startX+newAimPosX*objectMultiplier), (startY-newAimPosY*objectMultiplier), "dynamic")
		local bulletShape 	= love.physics.newCircleShape( bulletBig_radius )
		local fixture 		= love.physics.newFixture(body, bulletShape)
		local creation_time = love.timer.getTime()
		local bulletSpeed 	= 240

		fixture:setRestitution(1)
		body:setLinearDamping(0)
			
		fixture:setUserData("Bullet_Bomb"..tostring(creation_time))

		body:applyLinearImpulse(newAimPosX*bulletSpeed, newAimPosY*-bulletSpeed)
		body:setBullet(true) 

		table.insert(bullets_bomb, {fixture = fixture, body = body, creation_time = creation_time})
		
	elseif type == "ghost" then

		local body 			= love.physics.newBody(world, (startX+newAimPosX*objectMultiplier), (startY-newAimPosY*objectMultiplier), "dynamic")
		local bulletShape 	= love.physics.newCircleShape( bulletSmall_radius )
		local fixture 		= love.physics.newFixture(body, bulletShape)
		local creation_time = love.timer.getTime()
		local bulletSpeed 	= 250

		fixture:setRestitution(1)
		body:setLinearDamping(0)
			
		fixture:setUserData("Bullet_Ghst"..tostring(creation_time))

		body:applyLinearImpulse(newAimPosX*bulletSpeed, newAimPosY*-bulletSpeed)
		body:setBullet(true)

		table.insert(bullets_ghost, {fixture = fixture, body = body, creation_time = creation_time})
		
	end

end

function handleBullet()

	for i,v in pairs(bullets_normal) do

		if (v.creation_time + bullet_NormalLifeSpan <= love.timer.getTime( )) then

			bullet_NormalMisfire(v, i)

		end

	end

	for i,v in pairs(bullets_small) do

		if (v.creation_time + bullet_SmallLifeSpan <= love.timer.getTime( )) then

			bullet_SmallMisfire(v, i)

		end

	end

	for i,v in pairs(bullets_bomb) do

		if (v.creation_time + bullet_BombLifeSpan <= love.timer.getTime( )) then

			bullet_BombExplode(v, i)

		end

	end

	for i,v in pairs(bullets_ghost) do

		if (v.creation_time + bullet_SmallLifeSpan <= love.timer.getTime( )) then

			bullet_GhostMisfire(v, i)

		end

	end

end

function handleBulletCollision(bulletTime)

	for i,v in pairs(bullets_normal) do

		if (tostring(v.creation_time)) == bulletTime then

			v.body:destroy()
			table.remove(bullets_normal, i)

		end

	end

	for i,v in pairs(bullets_bomb) do

		if (tostring(v.creation_time)) == bulletTime then

			v.body:destroy()
			table.remove(bullets_bomb, i)

		end

	end

	for i,v in pairs(bullets_small) do

		if (tostring(v.creation_time)) == bulletTime then

			v.body:destroy()
			table.remove(bullets_small, i)

		end

	end

	for i,v in pairs(bullets_ghost) do

		if (tostring(v.creation_time)) == bulletTime then

			v.body:destroy()
			table.remove(bullets_ghost, i)

		end

	end

end

function drawBullet()
	
	for i,v in pairs(bullets_normal) do

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(bullet_Image_Big, v.body:getX()-8, v.body:getY()-8)
		
	end

	for i,v in pairs(bullets_small) do

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(bullet_Image_Small, v.body:getX()-4, v.body:getY()-4)
		
	end

	for i,v in pairs(bullets_bomb) do

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(bullet_Image_Bomb, v.body:getX()-8, v.body:getY()-8)
		
	end

	for i,v in pairs(bullets_ghost) do
		
	end

end

function debugBullet()

	for i,v in pairs(bullets_normal) do

		love.graphics.setColor(255, 255, 0, 255)
		love.graphics.circle("line", v.body:getX(), v.body:getY(), 6)
		love.graphics.setColor(255, 255, 255, 255)

	end

	for i,v in pairs(bullets_small) do

		love.graphics.setColor(255, 255, 0, 255)
		love.graphics.circle("line", v.body:getX(), v.body:getY(), 3)
		love.graphics.setColor(255, 255, 255, 255)

	end

	for i,v in pairs(bullets_bomb) do

		love.graphics.setColor(255, 255, 0, 255)
		love.graphics.circle("line", v.body:getX(), v.body:getY(), 6)
		love.graphics.setColor(255, 255, 255, 255)

	end

	for i,v in pairs(bullets_ghost) do

		love.graphics.setColor(255, 255, 0, 255)
		love.graphics.circle("line", v.body:getX(), v.body:getY(), 3)
		love.graphics.setColor(255, 255, 255, 255)

	end

end

function pauseBullet()

	for i,v in pairs(bullets_normal) do

		v.creation_time = v.creation_time + (love.timer.getTime( ) - v.creation_time)

	end

	for i,v in pairs(bullets_bomb) do

		v.creation_time = v.creation_time + (love.timer.getTime( ) - v.creation_time)

	end

end

function bullet_NormalMisfire(currentBody, tablePos)

	currentBody.body:destroy()
	table.remove(bullets_normal, tablePos)

end

function bullet_SmallMisfire(currentBody, tablePos)

	currentBody.body:destroy()
	table.remove(bullets_small, tablePos)

end

function bullet_GhostMisfire(currentBody, tablePos)

	currentBody.body:destroy()
	table.remove(bullets_ghost, tablePos)

end

function bullet_BombExplode(currentBody, tablePos)

	local subType	= "small"
	local posX		= currentBody.body:getX()
	local posY		= currentBody.body:getY()

	fireBullet(subType, posX, posY, 2, 2, world)
	fireBullet(subType, posX, posY, 2, -2, world)
	fireBullet(subType, posX, posY, -2, 2, world)
	fireBullet(subType, posX, posY, -2, -2, world)

	currentBody.body:destroy()
	table.remove(bullets_bomb, tablePos)

end

function destroyAllBullets()

	for i,v in ipairs(bullets_normal) do
		
		v.body:destroy()
		table.remove(bullets_normal, i)

	end

	for i,v in ipairs(bullets_small) do
		
		v.body:destroy()
		table.remove(bullets_small, i)

	end

	for i,v in ipairs(bullets_bomb) do
		
		v.body:destroy()
		table.remove(bullets_bomb, i)

	end

end

function executeWeaponFire(currentPlayer, currentSprite)

	if currentPlayer.refire <= math.floor(love.timer.getTime( )) then

		fireBullet(currentPlayer.ammo, currentSprite.body:getX(), currentSprite.body:getY(), newAimPosX, newAimPosY, world)
		
		if currentPlayer.ammo ~= "normal" then
			currentPlayer.ammo = "normal"
		end

		currentPlayer.refire = math.floor(love.timer.getTime( )) + playerRefireTime
		sound_FireWeapon()

	end

end