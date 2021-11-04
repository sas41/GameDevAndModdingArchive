--Read Settings from a file
function readSettings()

	if	( love.filesystem.exists("settings.txt") ) then

		local readLine = love.filesystem.lines( "settings.txt" )

		defaultResolutionW 	= tonumber(readLine())
		defaultResolutionH 	= tonumber(readLine())
		local isFullscreen	= readLine()
		local isBorderless	= readLine()
		local isScaled		= readLine()
		audioMusicVolume 	= tonumber(readLine())
		audioSFXVolume 		= tonumber(readLine())

		sound_SetVolume()

		if (isFullscreen == "true") then

        	graphicsFullscreen = true
            graphicsBorderless = false

    	elseif(isBorderless == "true") then

            graphicsBorderless = true
        	graphicsFullscreen = false

        elseif(isBorderless == "false") and (isFullscreen == "false") then

        	graphicsFullscreen = false
            graphicsBorderless = false

        end

		if (isScaled == "true" ) then
			graphicsScaling = true
		else
			graphicsScaling = false
		end

	end

end

--Write Settings to a file
function writeSettings(resW, resH, fullscreen, borderless, scaling, audiomusic, audiosfx, run)

	if(run == true) then

		if(fullscreen == true) then
			fullscreen = "true"
			borderless = "false"
		elseif(borderless == true) then
			borderless = "true" 
			fullscreen = "false"
		elseif(borderless == false) and (fullscreen == false) then
			borderless = "false" 
			fullscreen = "false"
		end

		if(scaling == true) then
			scaling = "true"
		else
			scaling = "false"
		end
		
		WriteSettings = resW.."\n"..resH.."\n"..fullscreen.."\n"..borderless.."\n"..scaling.."\n"..audiomusic.."\n"..audiosfx
		love.filesystem.write( "settings.txt", WriteSettings)
		
	end

end