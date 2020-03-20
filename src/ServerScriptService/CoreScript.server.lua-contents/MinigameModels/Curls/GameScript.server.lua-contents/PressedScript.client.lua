keys = {"a","b","c","d","e","f","g","h","j","k","l","m","n","p","q","r","s","t","u","v","w","x","y","z"}
player = game.Players.LocalPlayer
mouse = player:GetMouse()
correctpressed1 = false
correctpressed2 = false
correctpressed3 = false
wrongpressed = false
currentrequired = nil
phase = nil

mouse.KeyDown:connect(function(key)
	print("PressedKey")
	if game.Workspace.Curls.Playing.Value == true then
		if currentrequired then
			if wrongpressed == false then
				if phase then
					if string.lower("" ..key.. "") == string.lower(currentrequired) then
						if phase == "Key1" then
							correctpressed1 = true
							phase = "Key2"
						elseif phase == "Key2" then
							correctpressed2 = true
							game.Workspace.CurrentCamera.CameraSubject = game.Workspace.Curls.Torso2
							game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace.Curls.CameraPart2.Position, game.Workspace.Curls.Torso2.Position)
							phase = "Key3"
						elseif phase == "Key3" then
							correctpressed3 = true
							game.Workspace.CurrentCamera.CameraSubject = game.Workspace.Curls.Torso1
							game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace.Curls.CameraPart1.Position, game.Workspace.Curls.Torso1.Position)
						end
					elseif string.lower(key) ~= string.lower(currentrequired) then
						local found = false
						for i = 1, #keys do
							if "" ..key.. "" == keys[i] then
								found = true
							end
						end
						if found == true then
							wrongpressed = true
							tasktext.TextColor3 = Color3.new(1,0,0)
							wait(2)
							wrongpressed = false
							tasktext.TextColor3 = Color3.new(1,1,1)
						end
					end
				end
			end
		end
	end
end)

while true do
	randomkey1 = keys[math.random(1, #keys)]
	repeat randomkey2 = keys[math.random(1, #keys)] until randomkey2 ~= randomkey1
	repeat randomkey3 = keys[math.random(1, #keys)] until randomkey3 ~= randomkey2 and randomkey3 ~= randomkey1
	keyorder = "" ..randomkey1.. "" ..randomkey2.. "" ..randomkey3.. ""
	tasktext = player.PlayerGui:WaitForChild("TaskGUI"):WaitForChild("Frame"):WaitForChild("TaskText")
	score = player.PlayerGui:WaitForChild("TaskGUI"):WaitForChild("Frame"):WaitForChild("Score")
	tasktext.Text = "Press " ..string.upper(randomkey1).. ", " ..string.upper(randomkey2).. ", and " ..string.upper(randomkey3).. " in that order!"
	currentrequired = randomkey1
	phase = "Key1"
	repeat wait() until correctpressed1 == true
	currentrequired = randomkey2
	repeat wait() until correctpressed2 == true
	currentrequired = randomkey3
	repeat wait() until correctpressed3 == true
	game.Workspace.Curls["Curls_" ..player.Name.. ""].Value = game.Workspace.Curls["Curls_" ..player.Name.. ""].Value + 1
	score.Text = "Curls: " ..game.Workspace.Curls["Curls_" ..player.Name.. ""].Value.. ""
	tasktext.Text = " "
	correctpressed1 = false
	correctpressed2 = false
	correctpressed3 = false
	wrongpressed = false
	currentrequired = nil
	phase = nil
	wait(1)
end