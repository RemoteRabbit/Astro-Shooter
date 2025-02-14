local menu = {
	items = {
		{
			text = "Play Game",
			action = function()
				gameState.currentScreen = "game"
			end,
		},
		{
			text = "Settings",
			action = function()
				gameState.currentScreen = "settings"
			end,
		},
		{
			text = "Exit",
			action = function()
				love.event.quit()
			end,
		},
	},
	selected = 1,
}

function updateMenu(dt)
	if love.keyboard.wasPressed("up") then
		menu.selected = menu.selected - 1
		if menu.selected < 1 then
			menu.selected = #menu.items
		end
	end

	if love.keyboard.wasPressed("down") then
		menu.selected = menu.selected + 1
		if menu.selected > #menu.items then
			menu.selected = 1
		end
	end

	if love.keyboard.wasPressed("return") then
		menu.items[menu.selected].action()
	end
end

function drawMenu()
	love.graphics.setColor(0, 0.5, 1)
	love.graphics.setFont(titleFont)
	love.graphics.printf("Astro Shooter", 0, 100, love.graphics.getWidth(), "center")

	-- Menu items in white, selected item in green
	for i, item in ipairs(menu.items) do
		local y = 300 + (i - 1) * 50
		local text = item.text

		if i == menu.selected then
			love.graphics.setColor(0, 1, 0) -- Green for selected item
			text = "> " .. text .. " <"
		else
			love.graphics.setColor(1, 1, 1) -- White for other items
		end

		love.graphics.setFont(menuFont)
		love.graphics.printf(text, 0, y, love.graphics.getWidth(), "center")
	end

	-- Reset color to white after drawing

	love.graphics.setFont(menuFont)
	for i, item in ipairs(menu.items) do
		local y = 300 + (i - 1) * 50
		local text = item.text
		if i == menu.selected then
			text = "> " .. text .. " <"
		end
		love.graphics.printf(text, 0, y, love.graphics.getWidth(), "center")
	end
	love.graphics.setColor(1, 1, 1)
end
