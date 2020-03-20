--------IDs--------
customization = 187979130
startingmoney = 188371326
run = 188372710
balloon = 188376581
package = 188959428
--------IDs--------

game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)
		player:WaitForDataReady()
		if game:GetService("GamePassService"):PlayerHasPass(player, package) then
			game.ServerStorage["Bloxy Cola"]:Clone().Parent = player["Backpack"]
			game.ServerStorage["Customize"]:Clone().Parent = player["Backpack"]
			game.ServerStorage["RunGUI"]:Clone().Parent = player["PlayerGui"]
			game.ServerStorage["Balloon"]:Clone().Parent = player["Backpack"]
		else
			if game:GetService("GamePassService"):PlayerHasPass(player, customization) then
				game.ServerStorage["Customize"]:Clone().Parent = player["Backpack"]
			end
			if game:GetService("GamePassService"):PlayerHasPass(player, run) then
				game.ServerStorage["RunGUI"]:Clone().Parent = player["PlayerGui"]
			end
			if game:GetService("GamePassService"):PlayerHasPass(player, balloon) then
				game.ServerStorage["Balloon"]:Clone().Parent = player["Backpack"]
			end
		end
	end)
	player:WaitForDataReady()
	repeat wait() until player.leaderstats
	repeat wait() until player.leaderstats.Cash
	repeat wait() until player.Backpack
	repeat wait() until game.ServerStorage.Customize
	repeat wait() until game.ServerStorage.RunGUI
	repeat wait() until game.ServerStorage.Balloon
	if game:GetService("GamePassService"):PlayerHasPass(player, startingmoney) or game:GetService("GamePassService"):PlayerHasPass(player, package) then
		player["leaderstats"]["Cash"].Value = player["leaderstats"]["Cash"].Value + 200000
	end
end)