player = game.Players.LocalPlayer
status = "Walking"

script.Parent.MouseButton1Click:connect(function()
	if status == "Walking" then
		player.Character.Humanoid.WalkSpeed = 35
		script.Parent.Parent.Title.Text = "Walk"
		status = "Running"
	elseif status == "Running" then
		player.Character.Humanoid.WalkSpeed = 16
		script.Parent.Parent.Title.Text = "Run"
		status = "Walking"
	end
end)