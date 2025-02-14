require("menu")
require("settings")
require("keyboard")
require("game")

function love.resize(w, h)
	WindowHeight = h
	WindowWidth = w
	initGame()
end

function love.load()
	gameState = {
		currentScreen = "menu",
		isPaused = false,
		settings = {
			volume = 100,
			fullscreen = false,
			resolution = "1280x720",
		},
	}

	-- Load fonts
	titleFont = love.graphics.newFont(48)
	menuFont = love.graphics.newFont(24)

	local r, g, b, a = love.math.colorFromBytes(163, 63, 115, 0.8)
	love.graphics.setBackgroundColor(r, g, b, a)
	WindowWidth = love.graphics.getWidth()
	WindowHeight = love.graphics.getHeight()
end

function love.update(dt)
	if gameState.currentScreen == "menu" then
		updateMenu(dt)
	elseif gameState.currentScreen == "settings" then
		updateSettings(dt)
	elseif gameState.currentScreen == "game" then
		updateGame(dt)
	end
end

function love.draw()
	if gameState.currentScreen == "menu" then
		drawMenu()
	elseif gameState.currentScreen == "settings" then
		drawSettings()
	elseif gameState.currentScreen == "game" then
		drawGame()
	end
end
