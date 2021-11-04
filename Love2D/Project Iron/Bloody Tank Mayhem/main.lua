--Allow Debugging for Sublime Text
io.stdout:setvbuf("no")

--Load EVERYTHING!
require "init"

------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------

--On Load, do:
function love.load()

	--Read Settings
	readSettings()

	--Set the window resolution to the given defaults
	graphicsKickStart()

	addSongs()
	addMaps()

	sound_PlayIngameMusic()

	loadPlayerSprites()

	love.graphics.setFont(gameFont);
	
end

--This default (required) function will run code every tick
function love.update(dt)

	--Essential cleanup command for the sound engine
	TEsound.cleanup()

	--Globally tick timers
	countDownCheck()

	--Update the interface
	loveframes.update(dt)

	if gameOn == true and gamePaused == false then

		--Update the world and the map of the visualization engine.
		world:update(dt)
		map:update(dt)

		--Make sure Sprites match hitboxes
		updatePlayers()
		
		--Handle the player controles and bullet physics
		handlePlayers()
		handleBullet()

		--Check if the game is over.

		if gameEndChecker == true then
			victoryState()
		end

	elseif gameOn == true and gamePaused == true then

		--Make sure bullets don't disapear when the game is paused and unpaused
		pauseBullet()
		
	end

	updateAnimations(dt)

end

function love.draw()

	--Again, check if a game has started
	if gameOn == false then

		if gameOverState == true then

			gameOverScreen()
			if gameShowScoreBoard == true then
				showScore()
			end

		else
			drawMainMenuBackground()
			loveframes.draw()
		end

	elseif gameOn == true and gamePaused == false then

		drawWrold()

		if developer == true then

			debugEngine()
		
		end

	else

		loveframes.draw()
		
    end

    if gameOn == false or gamePaused == true then

    	drawCrosshair()
		drawAnimations()

    end

end

--Quit ze game
function love.quit()

  print("PROGRAM TERMINATED!")

end