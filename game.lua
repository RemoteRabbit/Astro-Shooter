function LoadImage(path)
	local info = love.filesystem.getInfo(path)
	if info then
		return love.graphics.newImage(path)
	end
	print("Could not find image at: " .. path)
	return nil
end

X, Y = 400, 400
Angle = 0
ShipImg = LoadImage("assets/ship.png")
pauseMenuSelected = 1

function handlePauseMenu()
	if love.keyboard.wasPressed("up") then
		pauseMenuSelected = pauseMenuSelected - 1
		if pauseMenuSelected < 1 then
			pauseMenuSelected = 3
		end
	end

	if love.keyboard.wasPressed("down") then
		pauseMenuSelected = pauseMenuSelected + 1
		if pauseMenuSelected > 3 then
			pauseMenuSelected = 1
		end
	end

	if love.keyboard.wasPressed("return") then
		if pauseMenuSelected == 1 then
			gameState.isPaused = false
		elseif pauseMenuSelected == 2 then
			gameState.currentScreen = "settings"
			gameState.isPaused = false
		elseif pauseMenuSelected == 3 then
			gameState.currentScreen = "menu"
			gameState.isPaused = false
		end
	end
end

function initGame()
	WindowWidth = love.graphics.getWidth()
	WindowHeight = love.graphics.getHeight()
	local scale = math.min(WindowWidth / ShipImg:getWidth(), WindowHeight / ShipImg:getHeight())
	scale = scale * 0.8
	print(scale)
	ShipScale = scale
end

function updateGame(dt)
	if love.keyboard.wasPressed("escape") then
		gameState.isPaused = not gameState.isPaused
		pauseMenuSelected = 1
	end

	if gameState.isPaused then
		handlePauseMenu()
	else
		if love.keyboard.isDown("a") then
			X = X - 100 * dt
			targetAngle = -math.pi / 2
			moved = true
		end
		if love.keyboard.isDown("d") then
			X = X + 100 * dt
			targetAngle = math.pi / 2
			moved = true
		end
		if love.keyboard.isDown("w") then
			Y = Y - 100 * dt
			targetAngle = 0
			moved = true
		end
		if love.keyboard.isDown("s") then
			Y = Y + 100 * dt
			targetAngle = math.pi
			moved = true
		end

		-- Diagonal movements
		if love.keyboard.isDown("w") and love.keyboard.isDown("d") then
			targetAngle = math.pi / 4 -- -45 degrees
		end
		if love.keyboard.isDown("w") and love.keyboard.isDown("a") then
			targetAngle = -math.pi / 4 -- 45 degrees
		end
		if love.keyboard.isDown("s") and love.keyboard.isDown("d") then
			targetAngle = 3 * math.pi / 4 -- -135 degrees
		end
		if love.keyboard.isDown("s") and love.keyboard.isDown("a") then
			targetAngle = -3 * math.pi / 4 -- 135 degrees
		end

		if moved then
			local rotationSpeed = 10
			local angleDiff = targetAngle - Angle

			while angleDiff > math.pi do
				angleDiff = angleDiff - 2 * math.pi
			end
			while angleDiff < -math.pi do
				angleDiff = angleDiff + 2 * math.pi
			end

			Angle = Angle + angleDiff * dt * rotationSpeed
		end
	end
end

function drawGame(dt)
	if ShipImg then
		love.graphics.draw(
			ShipImg,
			X + (ShipImg:getWidth() * ShipScale) / 2,
			Y + (ShipImg:getHeight() * ShipScale) / 2,
			Angle,
			ShipScale,
			ShipScale,
			ShipImg:getWidth() / 2,
			ShipImg:getHeight() / 2
		)
	end
	if gameState.isPaused then
		love.graphics.setColor(0, 0, 0, 0.7)
		love.graphics.rectangle("fill", 0, 0, WindowWidth, WindowHeight)
		love.graphics.setColor(1, 1, 1)
		love.graphics.setFont(titleFont)
		love.graphics.printf("PAUSED", 0, WindowHeight / 4, WindowWidth, "center")
		love.graphics.setFont(menuFont)
		local menuItems = {
			"Resume",
			"Settings",
			"Main Menu",
		}
		for i, item in ipairs(menuItems) do
			if i == pauseMenuSelected then
				love.graphics.setColor(0, 1, 0)
				text = "> " .. item .. " <"
			else
				love.graphics.setColor(1, 1, 1)
				text = item
			end
			love.graphics.printf(text, 0, WindowHeight / 2 + (i - 1) * 50, WindowWidth, "center")
		end
	end
	love.graphics.setColor(1, 1, 1)
end
