--Handle all kinds of input here
function love.mousepressed(x, y, button)

    if gameOn == false then
        callAnimations("explosion", x-50, y-50)
    end

    loveframes.mousepressed(x, y, button)

end
 
function love.mousereleased(x, y, button)
    loveframes.mousereleased(x, y, button)
end
 
function love.keypressed(key, unicode)
 
    loveframes.keypressed(key, unicode)

    if key == "escape" then
        inGameMenu()
    end

    if rebindState == true then
        rebindKey(key)
    end

    if key == "f1" then
        sound_PlayIngameMusic()
    end
 
end
 
function love.keyreleased(key)
    loveframes.keyreleased(key)
end

function love.textinput(text)
    loveframes.textinput(text)
end

function love.joystickpressed(joystick,button)

    if rebindState == true then
        rebindKey(button)
    end
   
end

function love.joystickpressed(joystick, button)

    if rebindState == true then
        rebindKey(button)
    end
   
end