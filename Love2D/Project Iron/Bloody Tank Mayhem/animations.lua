animation_Index = {}

function updateAnimations(dt)
	for i,v in ipairs(animation_Index) do
		animation_Index[i].animation:update(dt)
	end

	for i,v in ipairs(animation_Index) do
		if v.endTime <= love.timer.getTime( ) then
			table.remove(animation_Index, i)
		end
	end

end

function callAnimations(animation, posX, posY)

	local ct = love.timer.getTime( )

	if animation == nil then

		--do nothing

	elseif animation == "explosion" then

		local animation_Explosion = newAnimation(sprite_Explosion, 96, 96, 0.1, 0)
		animation_Explosion:setMode("once")
		table.insert(animation_Index, {animation = animation_Explosion, posX = posX, posY = posY, endTime = ct + 2})

	elseif animation == "something" then

		--Next Animation

	end

end

function drawAnimations()

	for i,v in ipairs(animation_Index) do

		animation_Index[i].animation:draw( animation_Index[i].posX, animation_Index[i].posY )

	end

end