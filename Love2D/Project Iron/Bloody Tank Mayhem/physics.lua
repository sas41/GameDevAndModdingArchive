function beginContact(a, b)

	if a:getUserData() == "Player" and string.sub(b:getUserData(), 1, 6) == "Bullet" then

		local bulletTime 	= string.sub(b:getUserData(), 12)

		if player1Active == true and a:getBody() == spriteLayer.player1.body then

			local player1DeathPosX, player1DeathPosY = spriteLayer.player1.body:getWorldCenter()
			callAnimations("explosion", player1DeathPosX-50, player1DeathPosY-50)
			player1Active = false
			spriteLayer.player1.body:destroy()

		end

		if player2Active == true and a:getBody() == spriteLayer.player2.body then

			local player2DeathPosX, player2DeathPosY = spriteLayer.player2.body:getWorldCenter()
			callAnimations("explosion", player2DeathPosX-50, player2DeathPosY-50)
			player2Active = false
			spriteLayer.player2.body:destroy()

		end

		if player3Active == true and a:getBody() == spriteLayer.player3.body then

			local player3DeathPosX, player3DeathPosY = spriteLayer.player3.body:getWorldCenter()
			callAnimations("explosion", player3DeathPosX-50, player3DeathPosY-50)
			player3Active = false
			spriteLayer.player3.body:destroy()

		end

		if player4Active == true and a:getBody() == spriteLayer.player4.body then

			local player4DeathPosX, player4DeathPosY = spriteLayer.player4.body:getWorldCenter()
			callAnimations("explosion", player4DeathPosX-50, player4DeathPosY-50)
			player4Active = false
			spriteLayer.player4.body:destroy()

		end

		handleBulletCollision(bulletTime)

	elseif a:getUserData() == "Player" and string.sub(b:getUserData(), 1, 7) == "PowerUp" then

		local powerUpType = string.sub(b:getUserData(), 9)

		if powerUpType == "bomb" then

			local floatX, floatY = a:getBody():getWorldCenter()
			addPickupInfo(pickupBomb, floatX, floatY)

		elseif powerUpType == "ghost" then

			local floatX, floatY = a:getBody():getWorldCenter()
			addPickupInfo(pickupGhost, floatX, floatY)

		end

		if player1Active == true and a:getBody() == spriteLayer.player1.body then

			spriteLayer.player1.ammo = powerUpType
			destroyPowerUp()
		
		end

		if player2Active == true and a:getBody() == spriteLayer.player2.body then

			spriteLayer.player2.ammo = powerUpType
			destroyPowerUp()

		end

		if player3Active == true and a:getBody() == spriteLayer.player3.body then

			spriteLayer.player3.ammo = powerUpType
			destroyPowerUp()

		end

		if player4Active == true and a:getBody() == spriteLayer.player4.body then

			spriteLayer.player4.ammo = powerUpType
			destroyPowerUp()

		end

	end



end

function endContact()

end

function preSolve()

end

function postSolve ()

end