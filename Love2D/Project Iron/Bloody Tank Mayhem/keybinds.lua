--SomeVaraibles
rebindState		= false
rebindTarget	= nil
rebindControl	= nil

--Set up user controles--Set up user controles
player1Controls		= {
	Type			= "keyboard",
	Up				= "w",
	Down			= "s",
	Left			= "a",
	Right			= "d",
	Fire			= "q",
}

player2Controls		= {
	Type			= "keyboard",
	Up				= "up",
	Down			= "down",
	Left			= "left",
	Right			= "right",
	Fire			= "end",
}

player3Controls		= {
	Type			= "keyboard",
	Up				= "kp8",
	Down			= "kp5",
	Left			= "kp4",
	Right			= "kp6",
	Fire			= "kp0",
}

player4Controls		= {
	Type			= "keyboard",
	Up				= "u",
	Down			= "j",
	Left			= "h",
	Right			= "k",
	Fire			= "i",
}

--A function to rebind the keys
function rebindKey(key)

	if key ~= "escape" then

		if rebindTarget.Type == "keyboard" then

			if rebindState == true then
				
				rebindTarget[rebindControl]	= key
				rebindState		= false
				rebindTarget	= nil
				resetMenus()

			end

		elseif rebindTarget.Type == "controller" then

			if rebindState == true then
				
				rebindTarget[rebindControl]	= tonumber(key)
				rebindState		= false
				rebindTarget	= nil
				resetMenus()

			end

		end

	else

		rebindState		= false
		rebindTarget	= nil

	end

end

