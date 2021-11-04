animation_Index = {}

function updateAnimations(dt)

	for i,v in ipairs(animation_Index) do
		animation_Index[i].animation:update(dt)
	end

	for i,v in ipairs(animation_Index) do
		if v.endTime <= love.timer.getTime( ) then
			table.remove(animation_Index, i)
		end
	end

	updatePlayerAnimations(dt)

end

function callAnimations(animation, posX, posY)

	local ct = love.timer.getTime( )

	if animation == nil then

		--do nothing

	elseif animation == "explosion" then


	elseif animation == "something" then

		--Next Animation

	end

end

function drawAnimations()

	for i,v in ipairs(animation_Index) do

		animation_Index[i].animation:draw( animation_Index[i].posX, animation_Index[i].posY )

	end

	drawPlayerAnimation()

end

function updatePlayerAnimations(dt)

	if playerIsShooting == false then

		if playerMovement == "idle" then

			if playerSide == "left" then

				if playerIsJumping == true then

					animation_player_idle_left:update(dt)

				elseif playerIsDown == true then

					animation_player_down_left:update(dt)

				else

					animation_player_idle_left:update(dt)

				end

			elseif playerSide == "right" then

				if playerIsJumping == true then

					animation_player_idle_right:update(dt)

				elseif playerIsDown == true then

					animation_player_down_right:update(dt)

				else

					animation_player_idle_right:update(dt)

				end

			end
			
		elseif playerMovement == "moving" then

			if playerSide == "left" then

				if playerIsJumping == true then

					animation_player_idle_left:update(dt)

				elseif playerIsDown == true then

					animation_player_crawling_left:update(dt)

				else

					animation_player_running_left:update(dt)

				end

			elseif playerSide == "right" then

				if playerIsJumping == true then

					animation_player_idle_right:update(dt)

				elseif playerIsDown == true then

					animation_player_crawling_right:update(dt)

				else

					animation_player_running_right:update(dt)

				end

			end

		end

	else

		if playerDirectionVertical == "m" then

			if playerDirectionHorizontal == "r" then
				--fire Right
			elseif playerDirectionHorizontal == "l" then
				--fire Left
			end

		elseif playerDirectionVertical == "u" then
			
			if playerDirectionHorizontal == "r" then
				--fire Up-Right
			elseif playerDirectionHorizontal == "l" then
				--fire Up-Left
			else
				--fire Up
			end

		elseif playerDirectionVertical == "d" then
			
			if playerDirectionHorizontal == "r" then
				--fire Down-Right
			elseif playerDirectionHorizontal == "l" then
				--fire Down-Left
			else
				--fire Down
			end
			
		end

	end

end

function drawPlayerAnimation()

	local playerX, playerY 	= map.layers["Sprite Layer"].player.body:getWorldCenter()
	local scale				= 1
	local drawPosX			= playerX-((100/2)-5)
	local drawPosY			= playerY-((100/2)+5)
	
	--love.graphics.draw(asset_player_sprite, playerX, playerY, 0, scale, scale, drawPosX, drawPosY)
	if playerIsShooting == false then

		if playerMovement == "idle" then

			if playerSide == "left" then

				if playerIsJumping == true then

					animation_player_idle_left:draw( drawPosX-10, drawPosY )

				elseif playerIsDown == true then

					animation_player_down_left:draw(  drawPosX-30, drawPosY+37 )

				else

					animation_player_idle_left:draw( drawPosX-10, drawPosY )

				end

			elseif playerSide == "right" then

				if playerIsJumping == true then

					animation_player_idle_right:draw( drawPosX, drawPosY )

				elseif playerIsDown == true then

					animation_player_down_right:draw(  drawPosX-10, drawPosY+37 )

				else

					animation_player_idle_right:draw( drawPosX, drawPosY )

				end

			end
			
		elseif playerMovement == "moving" then

			if playerSide == "left" then

				if playerIsJumping == true then

					animation_player_idle_left:draw( drawPosX-10, drawPosY )

				elseif playerIsDown == true then

					animation_player_crawling_left:draw( drawPosX-30, drawPosY+37 )

				else

					animation_player_running_left:draw( drawPosX-10, drawPosY )

				end

			elseif playerSide == "right" then

				if playerIsJumping == true then

					animation_player_idle_right:draw( drawPosX, drawPosY )

				elseif playerIsDown == true then

					animation_player_crawling_right:draw( drawPosX-10, drawPosY+37 )

				else

					animation_player_running_right:draw( drawPosX, drawPosY )

				end

			end

		end

	else

		if playerDirectionVertical == "m" then

			if playerDirectionHorizontal == "r" then
				--fire Right
			elseif playerDirectionHorizontal == "l" then
				--fire Left
			end

		elseif playerDirectionVertical == "u" then
			
			if playerDirectionHorizontal == "r" then
				--fire Up-Right
			elseif playerDirectionHorizontal == "l" then
				--fire Up-Left
			else
				--fire Up
			end

		elseif playerDirectionVertical == "d" then
			
			if playerDirectionHorizontal == "r" then
				--fire Down-Right
			elseif playerDirectionHorizontal == "l" then
				--fire Down-Left
			else
				--fire Down
			end
			
		end

	end

end

function debugAnimations()

	love.graphics.setColor(255, 255, 0, 255)
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
	love.graphics.print("Jump: "..tostring(playerIsJumping), 10, 30)
	love.graphics.print("Down: "..tostring(playerIsDown), 10, 50)
	love.graphics.print("Moving: "..playerMovement, 10, 70)
	love.graphics.print("Shooting: "..tostring(playerIsShooting), 10, 90)

end