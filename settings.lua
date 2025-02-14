local settings = {
	items = {
		{ text = "Volume", value = 100, min = 0, max = 100, step = 10 },
		{ text = "Fullscreen", value = false },
		{
			text = "Back to Menu",
			action = function()
				gameState.currentScreen = "menu"
			end,
		},
	},
	selected = 1,
}

function updateSettings(dt)
	if love.keyboard.wasPressed("up") then
		settings.selected = settings.selected - 1
		if settings.selected < 1 then
			settings.selected = #settings.items
		end
	end

	if love.keyboard.wasPressed("down") then
		settings.selected = settings.selected + 1
		if settings.selected > #settings.items then
			settings.selected = 1
		end
	end

	if love.keyboard.wasPressed("left") then
		local item = settings.items[settings.selected]
		if item.value ~= nil and item.step then
			item.value = math.max(item.min, item.value - item.step)
			gameState.settings.volume = item.value
		elseif type(item.value) == "boolean" then
			item.value = not item.value
			gameState.settings.fullscreen = item.value
			love.window.setFullscreen(item.value)
		end
	end

	if love.keyboard.wasPressed("right") then
		local item = settings.items[settings.selected]
		if item.value ~= nil and item.step then
			item.value = math.min(item.max, item.value + item.step)
			gameState.settings.volume = item.value
		elseif type(item.value) == "boolean" then
			item.value = not item.value
			gameState.settings.fullscreen = item.value
			love.window.setFullscreen(item.value)
		end
	end

	if love.keyboard.wasPressed("return") then
		local item = settings.items[settings.selected]
		if item.action then
			item.action()
		end
	end
end

function drawSettings()
	love.graphics.setFont(titleFont)
	love.graphics.printf("Settings", 0, 100, love.graphics.getWidth(), "center")

	love.graphics.setFont(menuFont)
	for i, item in ipairs(settings.items) do
		local y = 300 + (i - 1) * 50
		local text = item.text
		if item.value ~= nil then
			text = text .. ": " .. tostring(item.value)
		end
		if i == settings.selected then
			text = "> " .. text .. " <"
		end
		love.graphics.printf(text, 0, y, love.graphics.getWidth(), "center")
	end
end
