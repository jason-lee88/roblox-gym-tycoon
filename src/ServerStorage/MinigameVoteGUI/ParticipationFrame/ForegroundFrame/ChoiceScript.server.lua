local options = {script.Parent.Yes,
	script.Parent.No}
local currentVote

for _, option in ipairs (options) do
	option.MouseButton1Click:connect(function()
		if not currentVote and not option.Voted.Value then
			option.Voted.Value = true
			if option == script.Parent.Yes then
				script.Parent.Parent.Parent.Parent.Parent.Participating.Value = true
			elseif option == script.Parent.No then
				script.Parent.Parent.Parent.Parent.Parent.Participating.Value = false
			end
			option.BackgroundColor3 = Color3.new(0, 1, 0)
			currentVote = option
		elseif currentVote and not option.Voted.Value then
			currentVote.Voted.Value = false
			currentVote.BackgroundColor3 = Color3.new(1, 1, 1)
			option.Voted.Value = true
			if option == script.Parent.Yes then
				script.Parent.Parent.Parent.Parent.Parent.Participating.Value = true
			elseif option == script.Parent.No then
				script.Parent.Parent.Parent.Parent.Parent.Participating.Value = false
			end
			option.BackgroundColor3 = Color3.new(0, 1, 0)
			currentVote = option
		end
	end)
end