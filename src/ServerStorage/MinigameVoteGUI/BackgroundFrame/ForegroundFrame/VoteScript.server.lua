local options = {script.Parent.Minigame1,
	script.Parent.Minigame2,
	script.Parent.Minigame3}
local currentVote

for _, option in ipairs (options) do
	option.MouseButton1Click:connect(function()
		if not currentVote and not option.Voted.Value then
			option.Voted.Value = true
			game.Workspace["Votes" ..tostring(option.Text).. ""].Value = game.Workspace["Votes" ..tostring(option.Text).. ""].Value + 1
			option.BackgroundColor3 = Color3.new(0, 1, 0)
			currentVote = option
			script.Parent.Parent.Parent.Parent.Parent:WaitForChild("CurrentVote").Value = string.sub(option.Name, 9)
		elseif currentVote and not option.Voted.Value then
			currentVote.Voted.Value = false
			game.Workspace["Votes" ..tostring(currentVote.Text).. ""].Value = game.Workspace["Votes" ..tostring(currentVote.Text).. ""].Value - 1
			currentVote.BackgroundColor3 = Color3.new(1, 1, 1)
			option.Voted.Value = true
			game.Workspace["Votes" ..tostring(option.Text).. ""].Value = game.Workspace["Votes" ..tostring(option.Text).. ""].Value + 1
			option.BackgroundColor3 = Color3.new(0, 1, 0)
			currentVote = option
			script.Parent.Parent.Parent.Parent.Parent:WaitForChild("CurrentVote").Value = string.sub(option.Name, 9)
		end
	end)
end