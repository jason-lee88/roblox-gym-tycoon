local player = game.Players.LocalPlayer
player:WaitForChild("leaderstats")
player.leaderstats:WaitForChild("Strength")
player.leaderstats.Strength.Changed:connect(function(newValue)
game.Workspace.ScoreboardScript.UploadScore:InvokeServer()
end)