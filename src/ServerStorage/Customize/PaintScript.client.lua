local player = game.Players.LocalPlayer
local character = player.Character
local tool = script.Parent
local handle = tool.Handle
local currentcolor = script.Parent.CurrentColor
local mouse = player:GetMouse()
local mouseIcon = "rbxasset://textures\\FillCursor.png"
local defaultIcon = "rbxasset://textures\\ArrowCursor.png"

local equipped = false
local currentmodel = nil
local currentowner = nil
local model = Instance.new("Model", game.Workspace)
model.Name = "Customization_" ..player.Name.. ""

function moveMouse()
	if mouse.Target and equipped then
		local target = mouse.Target
		if target.Parent ~= currentmodel then
			for i,v in pairs(model:GetChildren()) do
				v:Destroy()
			end
		end
		if string.sub(target.Name, 1, 5) == "Group" then
			grouptype = string.sub(target.Name, 6)
			if target.Parent.Parent.Parent:findFirstChild("Owner") then
				currentowner = target.Parent.Parent.Parent.Owner.Value
				if currentowner.Name == player.Name then
					for i,v in pairs(target.Parent:GetChildren()) do
						if string.sub(v.Name, 6) == grouptype then
							local selectionBox = Instance.new("SelectionBox")
							selectionBox.Parent = model
							selectionBox.Adornee = v
							selectionBox.Color = currentcolor.Value
						end
					end
					currentmodel = target.Parent
				end
			end
		end
	elseif not mouse.Target and equipped then
		for i,v in pairs(game.Workspace["Customization_" ..player.Name.. ""]:GetChildren()) do
			v:Destroy()
		end
	end
end

function click()
	local target = mouse.Target
	if currentmodel then
		local playSound = false
		for i,v in pairs(currentmodel:GetChildren()) do
			if string.sub(v.Name, 6) == grouptype then
				v.BrickColor = currentcolor.Value
				if playSound == false and mouse.Target == v then
					playSound = true
				end
			end
		end
		if playSound == true then
			script.Parent.Handle.PaintSound:Play()
		end
	end
end

function mainColorGuiClick()
	player.PlayerGui.CustomizeGUI.PaletteFrame.Visible = true
end

function equip()
	equipped = true
	script.Parent.CustomizeGUI:Clone().Parent = player.PlayerGui
	player.PlayerGui.CustomizeGUI.ColorFrame.ColorImage.BackgroundColor3 = script.Parent.CurrentColor.Value.Color
	player.PlayerGui.CustomizeGUI.ColorFrame.ColorText.Text = script.Parent.CurrentColor.Value.Name
	player.PlayerGui:WaitForChild("CustomizeGUI"):WaitForChild("ColorFrame"):WaitForChild("ColorImage").MouseButton1Down:connect(mainColorGuiClick)
	if mouse.Icon ~= mouseIcon then
		mouse.Icon = mouseIcon
	end
	for i,v in pairs(player.PlayerGui:WaitForChild("CustomizeGUI"):WaitForChild("PaletteFrame"):GetChildren()) do
	v.TextButton.MouseButton1Click:connect(function()
		player.PlayerGui.CustomizeGUI.ColorFrame.ColorImage.BackgroundColor3 = v.TextButton.ColorValue.Value.Color
		player.PlayerGui.CustomizeGUI.ColorFrame.ColorText.Text = v.TextButton.ColorValue.Value.Name
		currentcolor.Value = BrickColor.new(player.PlayerGui.CustomizeGUI.ColorFrame.ColorImage.BackgroundColor3)
		player.PlayerGui.CustomizeGUI.PaletteFrame.Visible = false
		if mouse.Icon ~= mouseIcon then
			mouse.Icon = mouseIcon
		end
	end)
	player.PlayerGui.CustomizeGUI.ColorFrame.MouseEnter:connect(function()
		mouseEnterColorGUI()
	end)
	player.PlayerGui.CustomizeGUI.ColorFrame.MouseLeave:connect(function()
		mouseLeaveColorGUI()
	end)
	player.PlayerGui.CustomizeGUI.PaletteFrame.MouseEnter:connect(function()
		mouseEnterPaletteGUI()
	end)
	player.PlayerGui.CustomizeGUI.PaletteFrame.MouseLeave:connect(function()
		mouseLeavePaletteGUI()
	end)
end
end

function unequip()
	equipped = false
	for i,v in pairs(game.Workspace["Customization_" ..player.Name.. ""]:GetChildren()) do
		v:Destroy()
	end
	player.PlayerGui:findFirstChild("CustomizeGUI"):Destroy()
	if mouse.Icon ~= defaultIcon then
		mouse.Icon = defaultIcon
	end
end

function mouseEnterColorGUI()
	wait()
	if mouse.Icon ~= defaultIcon then
		mouse.Icon = defaultIcon
	end
end

function mouseEnterPaletteGUI()
	wait()
	if mouse.Icon ~= defaultIcon then
		mouse.Icon = defaultIcon
	end
end

function mouseLeaveColorGUI()
	if mouse.Icon ~= mouseIcon then
		mouse.Icon = mouseIcon
	end
end

function mouseLeavePaletteGUI()
	if mouse.Icon ~= mouseIcon then
		mouse.Icon = mouseIcon
	end
end

tool.Equipped:connect(equip)
tool.Unequipped:connect(unequip)
tool.Activated:connect(click)
mouse.Move:connect(moveMouse)