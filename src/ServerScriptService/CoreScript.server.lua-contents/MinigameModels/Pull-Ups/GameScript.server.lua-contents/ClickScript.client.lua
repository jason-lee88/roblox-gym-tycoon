local player = game.Players.LocalPlayer
local gui = player.PlayerGui:WaitForChild("TaskGUI"):WaitForChild("Frame"):WaitForChild("ClickButton")

local phase = "Down"

gui.MouseButton1Click:connect(function()
	if phase == "Down" then
		game.Workspace.CurrentCamera.CameraSubject = game.Workspace["Pull-Ups"].Focus1
		game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace["Pull-Ups"].CameraPart1.Position, game.Workspace["Pull-Ups"].Focus1.Position)
		gui.Parent.Score.Text = "Pull-Ups: " ..game.Workspace["Pull-Ups"]["Pull-Ups_" ..player.Name.. ""].Value.. ""
		gui.Size = UDim2.new(math.random(100, 250)/5000, 0, math.random(100, 250)/5000, 0)
		gui.Position = UDim2.new(math.random(400, 750)/1000, 0, math.random(400, 750)/1000, 0)
		phase = "Up"
	elseif phase == "Up" then
		game.Workspace.CurrentCamera.CameraSubject = game.Workspace["Pull-Ups"].Focus2
		game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace["Pull-Ups"].CameraPart2.Position, game.Workspace["Pull-Ups"].Focus2.Position)
		gui.Parent.Score.Text = "Pull-Ups: " ..game.Workspace["Pull-Ups"]["Pull-Ups_" ..player.Name.. ""].Value.. ""
		gui.Size = UDim2.new(math.random(100, 250)/5000, 0, math.random(100, 250)/5000, 0)
		gui.Position = UDim2.new(math.random(400, 750)/1000, 0, math.random(400, 750)/1000, 0)
		game.Workspace["Pull-Ups"]["Pull-Ups_" ..player.Name.. ""].Value = game.Workspace["Pull-Ups"]["Pull-Ups_" ..player.Name.. ""].Value + 1
		phase = "Down"
	end
end)