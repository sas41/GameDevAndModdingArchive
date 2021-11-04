function love.conf(configure)
	configure.window.icon = "assets/sprites/players/RedTank.png"
	configure.window.vsync = true
	configure.window.fsaa = 8
	configure.window.display = 1
	configure.window.highdpi = true
	configure.window.srgb = true
	configure.modules.joystick = true
	configure.modules.thread = true
end