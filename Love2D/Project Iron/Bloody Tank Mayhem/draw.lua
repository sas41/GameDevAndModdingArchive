--This one right here draws the map and the whole world...

function initiatePlayerDraw(player)

	local currentPlayer		= nil
	local currentPlayerBody	= nil

	if player==1 then
		currentPlayer		= spriteLayer.player1
		currentPlayerBody	= spriteLayer.player1.body
	elseif player==2 then
		currentPlayer		= spriteLayer.player2
		currentPlayerBody	= spriteLayer.player2.body
	elseif player==3 then
		currentPlayer		= spriteLayer.player3
		currentPlayerBody	= spriteLayer.player3.body
	elseif player==4 then
		currentPlayer		= spriteLayer.player4
		currentPlayerBody	= spriteLayer.player4.body
	end

	local playerIMG = love.graphics.newImage(currentPlayer.image)
	local playerX 	= currentPlayer.x
	local playerY 	= currentPlayer.y
	local playerR 	= currentPlayer.r
	local drawPosX 	= playerShapeX/2
	local drawPosY 	= playerShapeY/2

	love.graphics.draw(playerIMG, playerX, playerY, playerR, 1, 1, drawPosX, drawPosY)

end

function drawPlayers()

	if (player1Active) then
		initiatePlayerDraw(1)
	end
	if (player2Active) then
		initiatePlayerDraw(2)
	end
	if (player3Active) then
		initiatePlayerDraw(3)
	end
	if (player4Active) then
		initiatePlayerDraw(4)
	end

end

function drawExtraElements()

	drawBullet()

	drawPowerUp()

	drawAnimations()

	drawPickupInfo()

end

function drawIngameElements()

	drawExtraElements()
	drawPlayers()

	if developer == true then

		drawColBoxOverlay()

	end

end

function drawColBoxOverlay()

	debugPlayers("physics")
	debugBullet()
	debugWorld()

end

function drawWrold()

	if graphicsScaling == true then

		if defaultResolutionW/mapSizeX < defaultResolutionH/mapSizeY then
	
			local mapRatioX			= (defaultResolutionW/mapSizeX)
			local mapRatioY			= (defaultResolutionH/mapSizeY)
			local translatedMap		= math.floor(mapSizeY*mapRatioX)
			local mapPushY			= math.floor((defaultResolutionH/2)-((translatedMap)/2))

			love.graphics.translate(0, mapPushY)
			map:draw(mapRatioX, mapRatioX)

		elseif defaultResolutionW/mapSizeX >= defaultResolutionH/mapSizeY then

			local mapRatioX			= (defaultResolutionW/mapSizeX)
			local mapRatioY			= (defaultResolutionH/mapSizeY)
			local translatedMap		= math.floor(mapSizeX*mapRatioY)
			local mapPushX			= math.floor((defaultResolutionW/2)-((translatedMap)/2))
			
			love.graphics.translate(mapPushX, 0)
			map:draw(mapRatioY, mapRatioY)

		end

	else

		love.graphics.translate((defaultResolutionW/2)-mapSizeX/2, (defaultResolutionH/2)-mapSizeY/2)
		map:draw()

	end

end

--Set Collision debugging color and turn the function on
function debugWorld()

	love.graphics.setColor(255, 0, 0, 255)
	map:drawWorldCollision(collision)
	love.graphics.setColor(255, 255, 255, 255)

end

function drawCrosshair()

	local mousePosX, mousePosY = love.mouse.getPosition( )
	love.graphics.draw(crosshairImage, mousePosX, mousePosY, 0, 0.25, 0.25)
	
end

function drawPickupInfo()

	for i,v in pairs(table_pickupinfo) do

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(v.src, v.posX, v.posY)

		local currentTime = love.timer.getTime()

		if currentTime > v.creationTime + 2 then
			table.remove(table_pickupinfo, i)
		end
		
	end

end