--
--Handle all kinds of egnine input here
--
function love.mousepressed(x, y, button)

    loveframes.mousepressed(x, y, button)

end
 
function love.mousereleased(x, y, button)

    loveframes.mousereleased(x, y, button)

end
 
function love.keypressed(key, unicode)
 
    loveframes.keypressed(key, unicode)

end
 
function love.keyreleased(key)

    loveframes.keyreleased(key)

    if key == controls_player_move_down then

    	movePlayer("standup")

    end

end

function love.textinput(text)

    loveframes.textinput(text)

end

function love.joystickpressed(joystick,button)
   
end

function love.joystickpressed(joystick, button)

end

--
--Handle ingame input in here
--

function checkForGameInput()

	if love.keyboard.isDown(controls_player_move_down) then
		movePlayer("down")
		playerIsDown = true
		playerIsJumping = false
	end

	if love.keyboard.isDown(controls_player_move_up) then
		movePlayer("up")
		playerIsJumping = true
		playerIsDown = false
	end
	
	if love.keyboard.isDown(controls_player_move_up) == false and love.keyboard.isDown(controls_player_move_down) == false then

		playerIsDown = false
		playerIsJumping = false

	end

	if love.keyboard.isDown(controls_player_move_left) then
		movePlayer("left")
		playerMovement = "moving"
		playerSide = "left"
	elseif love.keyboard.isDown(controls_player_move_right) then
		movePlayer("right")
		playerMovement = "moving"
		playerSide = "right"
	else
		playerMovement = "idle"
	end

	if love.keyboard.isDown(controls_player_shoot_up) then
		playerDirectionVertical = "u"
		playerIsShooting = true
	elseif love.keyboard.isDown(controls_player_shoot_down) then
		playerDirectionVertical = "d"
		playerIsShooting = true
	else
		playerDirectionVertical = "m"
		if love.keyboard.isDown(controls_player_shoot_left) == false and love.keyboard.isDown(controls_player_shoot_right) == false then
			playerIsShooting = false
		end
	end

	if love.keyboard.isDown(controls_player_shoot_left) then
		playerDirectionHorizontal	= "l"
		playerIsShooting = true
	elseif love.keyboard.isDown(controls_player_shoot_right) then
		playerDirectionHorizontal	= "r"
		playerIsShooting = true
	else
		playerDirectionHorizontal	= "m"
		if love.keyboard.isDown(controls_player_shoot_up) == false and love.keyboard.isDown(controls_player_shoot_down) == false then
			playerIsShooting = false
		end
	end

end