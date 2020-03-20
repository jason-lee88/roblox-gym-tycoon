function script.UploadScore.OnServerInvoke(player)
    local inv = player:WaitForChild("leaderstats")
    local score = game:GetService("DataStoreService"):GetOrderedDataStore("Strength")
    score:SetAsync(player.Name, inv:FindFirstChild("Strength").Value)
end