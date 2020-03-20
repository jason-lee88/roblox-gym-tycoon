for i,v in pairs(game.Players:GetPlayers()) do
	if v.Participating.Value == true then
		i = Instance.new("IntValue", script.Parent)
		i.Name = "Pull-Ups_" ..v.Name.. ""
		script.TaskGUI:Clone().Parent = v.PlayerGui
		scriptclone = script.ClickScript:Clone()
		scriptclone.Parent = v.PlayerGui
		cameragiverclone = script.CameraGive:Clone()
		cameragiverclone.Parent = v.PlayerGui
		cameragiverclone.Disabled = false
	end
end
m = Instance.new("Message", game.Workspace)
m.Text = "Click the green box two times to do a full pull-up!"
wait(3)
m.Text = "Within 60 seconds, try to get the highest amount of pull-ups!"
wait(3)
m.Text = "The player with the most amount of pull-ups at the end wins!"
wait(3)
m:Destroy()
h = Instance.new("Hint", game.Workspace)
for i = 5, 1, -1 do
	h.Text = "The minigame begins in " ..i.. " seconds..."
	wait(1)
end
for i,v in pairs(game.Players:GetPlayers()) do
	if v.Participating.Value == true then
		if v.PlayerGui:findFirstChild("ClickScript") then
			v.PlayerGui:findFirstChild("ClickScript").Disabled = false
		end
	end
end
h.Text = "Begin!"
script.Parent.Playing.Value = true
wait(4)
for i = 60, 1, -1 do
	h.Text = "There are " ..i.. " seconds left in the minigame."
	wait(1)
end
h:Destroy()
m = Instance.new("Message", game.Workspace)
m.Text = "Stop!"
for i,v in pairs(game.Players:GetPlayers()) do
	if v.Participating.Value == true then
		if v.PlayerGui:findFirstChild("ClickScript") then
			v.PlayerGui:findFirstChild("ClickScript"):Destroy()
		end
	end
end
wait(2)
m:Destroy()
for i,v in pairs(game.Players:GetPlayers()) do
	if v.Participating.Value == true then
		if v.PlayerGui:findFirstChild("TaskGUI") then
			v.PlayerGui:findFirstChild("TaskGUI"):Destroy()
		end
	end
end
currentwinners = {}
highestscore = 0
winnernumber = 1
for i,v in pairs(script.Parent:GetChildren()) do
	if string.sub(v.Name, 1, 9) == "Pull-Ups_" then
		playername = string.sub(v.Name, 10)
		if game.Players[playername] then
			if v.Value == highestscore then
				s = Instance.new("StringValue", script.Parent)
				s.Name = "Winner" ..winnernumber.. ""
				s.Value = playername
				winnernumber = winnernumber + 1
			elseif v.Value > highestscore then
				winnernumber = 1
				for i,v in pairs(script.Parent:GetChildren()) do
					if string.sub(v.Name, 1, 6) == "Winner" then
						v:Destroy()
					end
				end
				s = Instance.new("StringValue", script.Parent)
				s.Name = "Winner" ..winnernumber.. ""
				s.Value = playername
				winnernumber = winnernumber + 1
				highestscore = v.Value
			end
		end
	end
end
for i,v in pairs(game.Players:GetPlayers()) do
	if v.Participating.Value == true then
		v:LoadCharacter()
	end
end
for i,v in pairs(game.Players:GetPlayers()) do
	if v.Participating.Value == true then
		camerarestoreclone = script.CameraRestore:Clone()
		camerarestoreclone.Parent = v.PlayerGui
		camerarestoreclone.Disabled = false
	end
end
script.Disabled = true