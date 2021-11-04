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

	showMainMenu()
	
end

--This default (required) function will run code every tick
function love.update(dt)

	--Essential cleanup command for the sound engine
	TEsound.cleanup()

	--Update the interface
	loveframes.update(dt)

	if gameIsOn == true then
		world:update(dt)
		checkForGameInput()
		updateAnimations(dt)
	end

end

--This default (required) function will do the drawing, after the tick from above!
function love.draw()

	if gameIsOn == true then
		drawMap()
		drawOver()
		debugAnimations()
	end

	loveframes.draw()

end

--This Function is called when the game is quitted.
function love.quit()

  print("PROGRAM TERMINATED!")

end