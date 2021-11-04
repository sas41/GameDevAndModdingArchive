--The following Funnction removes the file extention from a string of a file name
function removeFileExtension(file, extention)
    return string.sub(file, 1, string.find(file, extention)-1)
end

--Here we Check if the game is over
function victoryState()

	local alivePlayers = 0

	if player1Active == true then alivePlayers = alivePlayers + 1 end
	if player2Active == true then alivePlayers = alivePlayers + 1 end
	if player3Active == true then alivePlayers = alivePlayers + 1 end
	if player4Active == true then alivePlayers = alivePlayers + 1 end

	resetSpawns()

	if alivePlayers < 2 then
		countDown(3, endGame)
		gameEndChecker = false
	end
	
end

function endGame()

	destroyAllBullets()

	gameOn = false
	gamePaused = false
	gameStartState = false
	gameOverState = true

	if player1Active == true then
		score_Player1 = score_Player1 + 1
	end
	if player2Active == true then
		score_Player2 = score_Player2 + 1
	end
	if player3Active == true then
		score_Player3 = score_Player3 + 1
	end
	if player4Active == true then
		score_Player4 = score_Player4 + 1
	end

	countDown(3, function()

		gameOverState = false

		if gameLength > 1 then

			randomLevel()
	
		else

			gameOverState = true
			gameShowScoreBoard = true
			countDown(3, function()

				gameOverState = false
				gameShowScoreBoard = false
				showPregame()

				score_Player1 = 0
				score_Player2 = 0
				score_Player3 = 0
				score_Player4 = 0

			end)

		end

	end)

end

function showScore()

	love.graphics.draw(endScreenImage, 0, 0)

	love.graphics.setFont(scoreFont);

	if playerCount > 1 then
		love.graphics.print("Player 1 - "..score_Player1, (defaultResolutionW/2)-250, 50);
	end
	if playerCount > 1 then
		love.graphics.print("Player 2 - "..score_Player2, (defaultResolutionW/2)-250, 200);
	end
	if playerCount > 2 then
		love.graphics.print("Player 3 - "..score_Player3, (defaultResolutionW/2)-250, 350);
	end
	if playerCount > 3 then
		love.graphics.print("Player 4 - "..score_Player4, (defaultResolutionW/2)-250, 500);
	end

	love.graphics.setFont(gameFont);

end

--Make the title bigger or smaller randomly
function titleScreenScale()

	countDown(1, function()
		titleScale = (math.random(100, 50)/100)
		titleScreenScale()
	end)

end

--Set the window resolution to the given defaults with the selected mode and then start the menu
function graphicsKickStart()

    if (graphicsFullscreen == true) and (graphicsBorderless == false)then

    	love.window.setMode(0, 0, {borderless=true})

	elseif(graphicsFullscreen == false) and (graphicsBorderless == true) then

        love.window.setMode(defaultResolutionW, defaultResolutionH, {borderless=true})

    elseif(graphicsBorderless == false) and (graphicsFullscreen == false) then

        love.window.setMode(defaultResolutionW, defaultResolutionH, {borderless=false})

    end

	titleScreenScale()
    
    createAllUIElements()
	mainMenu()

	print("Is the Graphics card good enough?")
	print(love.graphics.isSupported("npot"))

end

--Draw the background and title image on the screen.
function drawMainMenuBackground()

	love.graphics.draw(backgroundImage, 0, 0)
	love.graphics.draw(titleImage, (defaultResolutionW/2), 70, 0, titleScale, titleScale, titleImage:getWidth( )/2, titleImage:getHeight( )/2)

end

function debugEngine()

	love.graphics.setColor(255, 255, 0, 255)
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

	love.graphics.print(love.timer.getTime( ), 10, 20)
	love.graphics.setColor(255, 255, 255, 255)

end

function countDown(time, func)

	table.insert(eventKeeper, {event = func, time = love.timer.getTime( ) + time})

end

function countDownCheck()

	for i,v in pairs(eventKeeper) do

		if (love.timer.getTime( ) > v.time) then

			v.event()
			table.remove(eventKeeper, i)

		end

	end

end

function gameOverScreen()

	local winner = nil

	if player1Active == true then
		--Player 1 Wins
		winner = "Player 1 Wins!"
	elseif player2Active == true then
		--Player 2 Wins
		winner = "Player 2 Wins!"
	elseif player3Active == true then
		--Player 3 Wins
		winner = "Player 3 Wins!"
	elseif player4Active == true then
		--Player 4 Wins
		winner = "Player 4 Wins!"
	else
		--It's a Tie
		winner = "   It's a Tie! "
	end

	love.graphics.draw(endScreenImage, 0, 0)
	love.graphics.setFont(scoreFont);
	love.graphics.print(winner, (defaultResolutionW/2)-300, (defaultResolutionH/2)-64);
	love.graphics.setFont(gameFont);

end

function randomLevel()

	local randomNumber = math.random(1, mapCount)
	defaultMap = maps[randomNumber]
	startGame()
	gameLength = gameLength - 1

end

function placePlayers()

	for i,v in ipairs(map.layers.spawns.objects) do

		table.insert(playerSpawns, {x = v.x, y = v.y, r = v.rotation})
		availableSpawnPoints = availableSpawnPoints + 1

	end

	local tempSpawnPoint = nil

	local function randomizeSpawn(sub)

		if sub == "begin" then
			tempSpawnPoint =  math.random(1, availableSpawnPoints)
		elseif sub == "end" then
			table.remove(playerSpawns, tempSpawnPoint)
			availableSpawnPoints = availableSpawnPoints - 1
		end

	end

	randomizeSpawn("begin")
		player1_StartPosX = playerSpawns[ tempSpawnPoint ].x
		player1_StartPosY = playerSpawns[ tempSpawnPoint ].y
		player1_Rotation  = playerSpawns[ tempSpawnPoint ].r
	randomizeSpawn("end")

	randomizeSpawn("begin")
		player2_StartPosX = playerSpawns[ tempSpawnPoint ].x
		player2_StartPosY = playerSpawns[ tempSpawnPoint ].y
		player2_Rotation  = playerSpawns[ tempSpawnPoint ].r
	randomizeSpawn("end")

	randomizeSpawn("begin")
		player3_StartPosX = playerSpawns[ tempSpawnPoint ].x
		player3_StartPosY = playerSpawns[ tempSpawnPoint ].y
		player3_Rotation  = playerSpawns[ tempSpawnPoint ].r
	randomizeSpawn("end")

	randomizeSpawn("begin")
		player4_StartPosX = playerSpawns[ tempSpawnPoint ].x
		player4_StartPosY = playerSpawns[ tempSpawnPoint ].y
		player4_Rotation  = playerSpawns[ tempSpawnPoint ].r
	randomizeSpawn("end")

end

function resetSpawns()

	availableSpawnPoints = 0

	for i,v in pairs(playerSpawns) do
		table.remove(playerSpawns, i)
	end

end

table_pickupinfo = {}
function addPickupInfo(source, positionX, positionY)

	table.insert(table_pickupinfo, { src = source, posX = positionX, posY = positionY, creationTime = love.timer.getTime() })

end