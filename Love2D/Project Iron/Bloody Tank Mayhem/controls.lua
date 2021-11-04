playerAimLength		= 400
playerTurnRate		= 0.03
playerRefireTime	= 2--seconds

--Player Handling goes here!

function movementHandler(player, movement)

	if gameStartState == false then
		if player == 1 then
			currentPlayer = spriteLayer.player1
			currentSprite = map.layers["Sprite Layer"].player1
		elseif player == 2 then
			currentPlayer = spriteLayer.player2
			currentSprite = map.layers["Sprite Layer"].player2
		elseif player == 3 then
			currentPlayer = spriteLayer.player3
			currentSprite = map.layers["Sprite Layer"].player3
		elseif player == 4 then
			currentPlayer = spriteLayer.player4
			currentSprite = map.layers["Sprite Layer"].player4
		end

		playerAngle = currentSprite.body:getAngle()
		newAimPosX = math.sin(playerAngle)
		newAimPosY = math.cos(playerAngle)

		if movement == "up" then
			currentPlayer.body:applyLinearImpulse(newAimPosX*playerAimLength, newAimPosY*-playerAimLength)
		end
		if movement == "down" then
			currentPlayer.body:applyLinearImpulse(newAimPosX*-playerAimLength, newAimPosY*playerAimLength)
		end
		if movement == "left" then
			playerAngle = playerAngle - playerTurnRate
		end
		if movement == "right" then
			playerAngle = playerAngle + playerTurnRate
		end
		if movement == "fire" then
			executeWeaponFire(currentPlayer, currentSprite)
		end

		currentPlayer.body:setAngle( playerAngle )
		currentSprite.r = playerAngle
		
	end

end

function player1Binds()
	if player1Active == true then
		checkInputs(player1Controls, 1)
	end
end

function player2Binds()
	if player2Active == true then
		checkInputs(player2Controls, 2)
	end
end

function player3Binds()
	if player3Active == true then
		checkInputs(player3Controls, 3)
	end
end

function player4Binds()
	if player4Active == true then
		checkInputs(player4Controls, 4)
	end
end

function checkInputs(player, playerNum)

	local thisPlayer=player
	local thisPlayerNum = playerNum

	if thisPlayer.Type == "keyboard" then

		if love.keyboard.isDown(thisPlayer.Up) then
			movementHandler(thisPlayerNum, "up")
		end

		if love.keyboard.isDown(thisPlayer.Down) then
			movementHandler(thisPlayerNum, "down")
		end

		if love.keyboard.isDown(thisPlayer.Left) then
			movementHandler(thisPlayerNum, "left")
		end

		if love.keyboard.isDown(thisPlayer.Right) then
			movementHandler(thisPlayerNum, "right")
		end

		if love.keyboard.isDown(thisPlayer.Fire) then
			movementHandler(thisPlayerNum, "fire")
		end

	elseif thisPlayer.Type == "controller" then

		if connectedContollers[playerNum]:getAxis(2)<0 then
			movementHandler(thisPlayerNum, "up")
		end

		if  connectedContollers[playerNum]:getAxis(2)>0 then
			movementHandler(thisPlayerNum, "down")
		end

		if connectedContollers[playerNum]:getAxis(1)<0 then
			movementHandler(thisPlayerNum, "left")
		end
		
		if connectedContollers[playerNum]:getAxis(1)>0 then
			movementHandler(thisPlayerNum, "right")
		end

		if connectedContollers[playerNum].isDown(connectedContollers[playerNum], thisPlayer.Fire) then
			movementHandler(thisPlayerNum, "fire")
		end

	end

end

function handlePlayers()
	
	player1Binds()
	player2Binds()
	player3Binds()
	player4Binds()

end