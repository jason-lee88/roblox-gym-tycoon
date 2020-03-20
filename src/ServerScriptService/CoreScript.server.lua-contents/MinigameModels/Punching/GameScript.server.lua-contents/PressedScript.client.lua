player = game.Players.LocalPlayer
mouse = player:GetMouse()
poweringup = true
acquiredpower = nil
currentwaittime = nil
redcolor = nil
greencolor = nil

repeat powerposition = math.random(10,100)/100 until powerposition ~= 1
redcolor = 1 - powerposition
greencolor = powerposition
motion = "Up"

mouse.KeyDown:connect(function(key)
	if string.byte(key) == 32 then
		if poweringup == true then
			poweringup = false
			local powerbar = script.Parent:WaitForChild("TaskGUI"):WaitForChild("Frame"):WaitForChild("PowerFrame"):WaitForChild("PowerBar")
			if powerbar then
				acquiredpower = math.floor(powerbar.Size.X.Scale*100)
				local currentwaittime = 7 - (powerbar.Size.X.Scale * 5.5)
				powerbar.Visible = false
				if acquiredpower >= 100 then
					game.Workspace.Punching["Punching_" ..player.Name.. ""].Value = game.Workspace.Punching["Punching_" ..player.Name.. ""].Value + acquiredpower + 50
				else
					game.Workspace.Punching["Punching_" ..player.Name.. ""].Value = game.Workspace.Punching["Punching_" ..player.Name.. ""].Value + acquiredpower
				end
				powerbar.Parent.Parent.Score.Text = "Score: " ..game.Workspace.Punching["Punching_" ..player.Name.. ""].Value.. ""
				game.Workspace.CurrentCamera.CameraSubject = game.Workspace["Punching"].Focus2
				game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace["Punching"].CameraPart2.Position, game.Workspace["Punching"].Focus2.Position)
				wait(currentwaittime)
				repeat powerposition = math.random(10, 100)/100 until powerposition ~= 1
				game.Workspace.CurrentCamera.CameraSubject = game.Workspace["Punching"].Focus1
				game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace["Punching"].CameraPart1.Position, game.Workspace["Punching"].Focus1.Position)
				redcolor = 1 - powerposition
				greencolor = powerposition
				motion = "Up"
				powerbar.Size = UDim2.new(powerposition, 0, 1, 0)
				powerbar.BackgroundColor3 = Color3.new(redcolor, greencolor, 0)
				powerbar.Visible = true
				poweringup = true
			end
		end
	end
end)

while true do
	if poweringup == true then
		local powerbar = script.Parent:WaitForChild("TaskGUI"):WaitForChild("Frame"):WaitForChild("PowerFrame"):WaitForChild("PowerBar")
		if powerbar.Visible then
			powerbar.Size = UDim2.new(powerposition, 0, 1, 0)
			powerbar.BackgroundColor3 = Color3.new(redcolor, greencolor, 0)
			if motion == "Up" and powerposition < 1 then
				powerposition = powerposition + .05
				redcolor = 1 - powerposition
				greencolor = powerposition
			elseif motion == "Down" and powerposition > 0 then
				powerposition = powerposition - .05
				redcolor = 1 - powerposition
				greencolor = powerposition
			elseif motion == "Up" and powerposition >= 1 then
				powerposition = powerposition - .05
				redcolor = 1 - powerposition
				greencolor = powerposition
				motion = "Down"
			elseif motion == "Down" and powerposition <= 0 then
				powerposition = powerposition + .05
				redcolor = 1 - powerposition
				greencolor = powerposition
				motion = "Up"
			end
		end
	end
	wait()
end