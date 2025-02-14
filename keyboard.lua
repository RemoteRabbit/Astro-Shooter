local keyboard = {}
local pressed = {}

function love.keypressed(key)
	pressed[key] = true
end

function love.keyboard.wasPressed(key)
	local wasPressed = pressed[key]
	pressed[key] = false
	return wasPressed
end

function love.keyreleased(key)
	pressed[key] = false
end
