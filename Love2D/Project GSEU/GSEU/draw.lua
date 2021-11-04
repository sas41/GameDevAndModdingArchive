function drawMap()

	if graphicsScaling == true then

		local scalingRatio		= (gameResH/1088)
		--local translatedMap		= math.floor(mapSizeX*mapRatioY)
		--local mapPushX			= math.floor((defaultResolutionW/2)-((translatedMap)/2))
		
		--love.graphics.translate(mapPushX, 0)
		map:draw(scalingRatio, scalingRatio)

	else

		--love.graphics.translate((defaultResolutionW/2)-mapSizeX/2, (defaultResolutionH/2)-mapSizeY/2)
		map:draw()

	end

end

function drawOver()

	-- Override Update callback
	function spriteLayer:update(dt)

	end

	-- Override Draw callback
	function spriteLayer:draw()

		drawPlayerHitBox()
		drawAnimations()

	end

end

function drawPlayerHitBox()

	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.polygon("line", map.layers["Sprite Layer"].player.body:getWorldPoints(map.layers["Sprite Layer"].player.shape:getPoints()))
	love.graphics.setColor(255, 255, 255, 255)

end