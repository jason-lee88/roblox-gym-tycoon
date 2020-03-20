DataStore = game:GetService("DataStoreService"):GetDataStore("Strength")

game.Players.PlayerAdded:connect(function(player)
	player:WaitForDataReady()
	repeat wait() until player.leaderstats
	repeat wait() until player.leaderstats.Strength
	local s = player.leaderstats.Strength
	s.Value = DataStore:GetAsync("Strength_" ..player.userId.. "")
	s.Changed:connect(function(newValue)
		DataStore:SetAsync("Strength_" ..player.userId.. "", s.Value)
	end)
end)