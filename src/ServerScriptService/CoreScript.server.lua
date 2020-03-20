tycoonBackups = {}
admins = {"Discern", "Overdash"}
banned = {}
muted = {}
allminigames = {"Curls", "Pull-Ups", "Punching"}
chosenminigames = {}
currentminigame = nil
winninggames = {}
minigamewinners = {}
phase = nil
maxplayers = 2
votingsessiontime = 120
minigamebegincountdown = 5
mostvotes = 0
minigamemodels = script:WaitForChild("MinigameModels")
pointsservice = game:GetService("PointsService")

for i,v in pairs(game.Workspace:GetChildren()) do
	if v:IsA("Model") and string.sub(v.Name, 1, 6) == "Tycoon" then
		tycoonBackups[v.Name] = v:Clone()
	end
end

function getTycoonFromPlayer(player)
	local found = false
	for i,v in pairs(game.Workspace:GetChildren()) do
		if v:IsA("Model") and string.sub(v.Name, 1, 6) == "Tycoon" then
			if v.Owner.Value == player then
				found = true
				table.insert(tycoonBackups, v.Owner.Value.Name)
				return v
			end
		end
	end
	if found == false then
		return nil
	end
end

function findPlayer(name, speaker)
	if string.lower(name) == "all" then
		local chars = {}
		for i,v in pairs(game.Players:GetPlayers()) do
			table.insert(chars, v)
		end
		return chars
	elseif string.lower(name) == "nonadmins" then
		local numberplayers = 0
		local chars = {}
		for i,v in pairs(game.Players:GetPlayers()) do
			local isadmin = false
			for n,m in pairs(admins) do
				if m == v.Name then
					isadmin = true
				end
			end 
			if isadmin == false then
				numberplayers = numberplayers + 1
				table.insert(chars, v)
			end
			if numberplayers == 0 then
				return nil
			else
				return chars
			end
		end
	elseif string.lower(name) == "admins" then
		local numberplayers = 0
		local chars = {}
		for i,v in pairs(game.Players:GetPlayers()) do
			local isadmin = false
			for n,m in pairs(admins) do
				if m == v.Name then
					isadmin = true
				end
			end 
			if isadmin == true then
				numberplayers = numberplayers + 1
				table.insert(chars, v)
			end
			if numberplayers == 0 then
				return nil
			else
				return chars
			end
		end
	elseif string.lower(name) == "random" then
		local chars = {}
		local randomplayer = game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]
		table.insert(chars, randomplayer)
		return chars
	elseif string.lower(name) == "me" then
		local chars = {speaker}
		return chars
	elseif string.lower(name) == "others" then
		local chars = {}
		for i,v in pairs(game.Players:GetPlayers()) do
			if v.Name ~= speaker.Name then
				table.insert(chars, v)
			end
		end
		return chars
	else
		local chars = {}
		local playerfound = false
		for i,v in pairs(game.Players:GetPlayers()) do
			if string.lower(string.sub(v.Name, 1, string.len(name))) == string.lower(name) then
				playerfound = true
				table.insert(chars, v)
				return chars
			end
		end
		if not playerfound then
			return nil
		end
	end
end

function chat(msg, player, character)
	if string.lower(string.sub(msg, 1, 6)) == "!kill-" then
		local chars = findPlayer(string.sub(msg, 7), player)
		for i,v in pairs(chars) do
			repeat wait() until v.Character
			game.Players["" ..v.Name.. ""].Character:BreakJoints()
		end
	elseif string.lower(string.sub(msg, 1, 6)) == "!kick-" then
		local chars = findPlayer(string.sub(msg, 7), player)
		for i,v in pairs(chars) do
			game.Players["" ..v.Name.. ""]:Kick()
		end
	elseif string.lower(string.sub(msg, 1, 5)) == "!ban-" then
		local chars = findPlayer(string.sub(msg, 6), player)
		for i,v in pairs(chars) do
			game.Players["" ..v.Name.. ""]:Kick()
			table.insert(banned, v.Name)
		end
	elseif string.lower(string.sub(msg, 1, 7)) == "!unban-" then
		local chars = findPlayer(string.sub(msg, 8), player)
		for i,v in pairs(chars) do
			for i = 1, #banned do
				if v.Name == banned[i] then
					table.remove(banned[i])
				end
			end
		end
	elseif string.lower(string.sub(msg, 1, 6)) == "!mute-" then
		local chars = findPlayer(string.sub(msg, 7), player)
		for i,v in pairs(chars) do
			local muteclone = script.MuteScript:Clone()
			muteclone.Parent = v.PlayerGui
			muteclone.Disabled = false
			table.insert(muted, v.Name)
		end
	elseif string.lower(string.sub(msg, 1, 8)) == "!unmute-" then
		local chars = findPlayer(string.sub(msg, 9), player)
		for i,v in pairs(chars) do
			for i = 1, #muted do
				if v.Name == muted[i] then
					local unmuteclone = script.UnmuteScript:Clone()
					unmuteclone.Parent = v.PlayerGui
					unmuteclone.Disabled = false
					table.remove(muted[i])
				end
			end
		end
	elseif string.lower(string.sub(msg, 1, 7)) == "!speed-" then
		local findslash = nil
		for i = 8, string.len(msg) do
			if string.sub(msg, i, i) == "-" then
				findslash = i
				break
			end
		end
		if findslash then
			local targetspeed = string.sub(msg, findslash + 1)
			local chars = findPlayer(string.sub(msg, 8, findslash - 1), player)
			for i,v in pairs(chars) do
				repeat wait() until v.Character
				game.Players["" ..v.Name.. ""].Character:WaitForChild("Humanoid").WalkSpeed = targetspeed
			end
		end
	elseif string.lower(string.sub(msg, 1, 3)) == "!m-" then
		local findslash = nil
		for i = 4, string.len(msg) do
			if string.sub(msg, i, i) == "-" then
				findslash = i
				break
			end
		end
		if findslash then
			local messagetime = string.sub(msg, findslash + 1)
			local messagetext = string.sub(msg, 4, findslash - 1)
			local m = Instance.new("Message", game.Workspace)
			m.Text = "" ..messagetext.. ""
			game.Debris:AddItem(m, messagetime)
		elseif not findslash then
			local messagetext = string.sub(msg, 4)
			local m = Instance.new("Message", game.Workspace)
			m.Text = "" ..messagetext.. ""
			game.Debris:AddItem(m, 4)
		end
	elseif string.lower(string.sub(msg, 1, 3)) == "!h-" then
		local findslash = nil
		for i = 4, string.len(msg) do
			if string.sub(msg, i, i) == "-" then
				findslash = i
				break
			end
		end
		if findslash then
			local hinttime = string.sub(msg, findslash + 1)
			local hinttext = string.sub(msg, 4, findslash - 1)
			local h = Instance.new("Hint", game.Workspace)
			h.Text = "" ..hinttext.. ""
			game.Debris:AddItem(h, hinttime)
		elseif not findslash then
			local hinttext = string.sub(msg, 4)
			local h = Instance.new("Hint", game.Workspace)
			h.Text = "" ..hinttext.. ""
			game.Debris:AddItem(h, 4)
		end
	elseif string.lower(string.sub(msg, 1, 4)) == "!tp-" then
		local findslash = nil
		for i = 5, string.len(msg) do
			if string.sub(msg, i, i) == "-" then
				findslash = i
				break
			end
		end
		if findslash then
			local char2 = findPlayer(string.sub(msg, findslash + 1))
			local chars = findPlayer(string.sub(msg, 5, findslash - 1), player)
			if #char2 == 1 then
				for i,v in pairs(chars) do
					repeat wait() until v.Character
					repeat wait() until char2[1].Character.Torso
					if v.Character:findFirstChild("Torso") and char2[1].Character:findFirstChild("Torso") then
						v.Character.Torso.CFrame = char2[1].Character.Torso.CFrame
					end
				end
			end
		end
	elseif string.lower(string.sub(msg, 1, 12)) == "!changecash-" then
		local findslash = nil
		for i = 13, string.len(msg) do
			if string.sub(msg, i, i) == "-" then
				findslash = i
				break
			end
		end
		if findslash then
			local targetcash = string.sub(msg, findslash + 1)
			local chars = findPlayer(string.sub(msg, 13, findslash - 1), player)
			for i,v in pairs(chars) do
				game.Players["" ..v.Name.. ""]:WaitForChild("leaderstats"):WaitForChild("Cash").Value = targetcash
			end
		end
	elseif string.lower(string.sub(msg, 1, 9)) == "!addcash-" then
		local findslash = nil
		for i = 10, string.len(msg) do
			if string.sub(msg, i, i) == "-" then
				findslash = i
				break
			end
		end
		if findslash then
			local targetcash = string.sub(msg, findslash + 1)
			local chars = findPlayer(string.sub(msg, 10, findslash - 1), player)
			for i,v in pairs(chars) do
				game.Players["" ..v.Name.. ""]:WaitForChild("leaderstats"):WaitForChild("Cash").Value = game.Players["" ..v.Name.. ""]:WaitForChild("leaderstats"):WaitForChild("Cash").Value + targetcash
			end
		end
	elseif string.lower(string.sub(msg, 1, 16)) == "!changestrength-" then
		local findslash = nil
		for i = 17, string.len(msg) do
			if string.sub(msg, i, i) == "-" then
				findslash = i
				break
			end
		end
		if findslash then
			local targetstrength = string.sub(msg, findslash + 1)
			local chars = findPlayer(string.sub(msg, 17, findslash - 1), player)
			for i,v in pairs(chars) do
				game.Players["" ..v.Name.. ""]:WaitForChild("leaderstats"):WaitForChild("Strength").Value = targetstrength
			end
		end
	elseif string.lower(string.sub(msg, 1, 13)) == "!addstrength-" then
		local findslash = nil
		for i = 14, string.len(msg) do
			if string.sub(msg, i, i) == "-" then
				findslash = i
				break
			end
		end
		if findslash then
			local targetstrength = string.sub(msg, findslash + 1)
			local chars = findPlayer(string.sub(msg, 14, findslash - 1), player)
			for i,v in pairs(chars) do
				game.Players["" ..v.Name.. ""]:WaitForChild("leaderstats"):WaitForChild("Strength").Value = game.Players["" ..v.Name.. ""]:WaitForChild("leaderstats"):WaitForChild("Strength").Value + targetstrength
			end
		end
	end
end

game.Players.PlayerAdded:connect(function(player)
	player:WaitForDataReady()
	local l = Instance.new("IntValue", player)
	l.Name = "leaderstats"
	local c = Instance.new("IntValue", l)
	c.Name = "Cash"
	local s = Instance.new("IntValue", l)
	s.Name = "Strength"
	local o = Instance.new("BoolValue", player)
	o.Name = "OwnsTycoon"
	local m = Instance.new("BoolValue", player)
	m.Name = "Muted"
	local v = Instance.new("StringValue", player)
	v.Name = "CurrentVote"
	local p = Instance.new("BoolValue", player)
	p.Name = "Participating"
	for i,v in pairs(banned) do
		if player.Name == v then
			player:Kick()
		end
	end
	local music = game.ServerStorage:WaitForChild("Music"):Clone()
	music.Parent = player
	music:Play()
	player.Chatted:connect(function(msg)
		repeat wait() until player.Character
		for i,v in pairs(admins) do
			if player.Name == v then
				chat(msg, player, player.Character)
			end
		end
	end)
	player.CharacterAdded:connect(function(character)
		if player:WaitForChild("Muted").Value == true then
			local muteclone = script.MuteScript:Clone()
			muteclone.Parent = player.PlayerGui
			muteclone.Disabled = false
		end
		if player:WaitForChild("CurrentVote").Value ~= nil then
			player.PlayerGui:WaitForChild("MinigameVoteGUI"):WaitForChild("BackgroundFrame"):WaitForChild("ForegroundFrame"):WaitForChild("Minigame" ..player.CurrentVote.Value.. "").Voted.Value = true
			player.PlayerGui:WaitForChild("MinigameVoteGUI"):WaitForChild("BackgroundFrame"):WaitForChild("ForegroundFrame"):WaitForChild("Minigame" ..player.CurrentVote.Value.. "").BackgroundColor3 = Color3.new(0,1,0)
		end
	end)
end)

game.Players.PlayerRemoving:connect(function(player)
	local tycoon = getTycoonFromPlayer(player)
	if tycoon then
		local backup = tycoonBackups[tycoon.Name]:Clone()
		tycoon:Destroy()
		wait()
		backup.Parent=game.Workspace
	end
end)

game.Workspace.ChildAdded:connect(function(item)
	if item:IsA("Hat") or item:IsA("Tool") then
		item:Destroy()
	end
end)

while true do
	phase = "Waiting For More Players"
	h = Instance.new("Hint", game.Workspace)
	repeat h.Text = "There must be at least " ..maxplayers.. " players in the server to play minigames! " ..maxplayers - #game.Players:GetPlayers().. " more players needed." wait() until #game.Players:GetPlayers() >= maxplayers
	h:Destroy()
	phase = "Set-Up"
	for i,v in pairs(game.Players:GetPlayers()) do
		game.ServerStorage.MinigameVoteGUI:Clone().Parent = v.PlayerGui
	end
	game.ServerStorage.MinigameVoteGUI:Clone().Parent = game.StarterGui
	randomminigame1 = allminigames[math.random(1, #allminigames)]
	repeat randomminigame2 = allminigames[math.random(1, #allminigames)] until randomminigame2 ~= randomminigame1
	repeat randomminigame3 = allminigames[math.random(1, #allminigames)] until randomminigame3 ~= randomminigame1 and randomminigame3 ~= randomminigame2
	table.insert(chosenminigames, randomminigame1)
	table.insert(chosenminigames, randomminigame2)
	table.insert(chosenminigames, randomminigame3)
	game.Workspace.VotesMinigame1.Name = "Votes" ..randomminigame1.. ""
	game.Workspace.VotesMinigame2.Name = "Votes" ..randomminigame2.. ""
	game.Workspace.VotesMinigame3.Name = "Votes" ..randomminigame3.. ""
	game.StarterGui:WaitForChild("MinigameVoteGUI"):WaitForChild("BackgroundFrame"):WaitForChild("ForegroundFrame"):WaitForChild("Minigame1").Text = "" ..randomminigame1.. ""
	game.StarterGui:WaitForChild("MinigameVoteGUI"):WaitForChild("BackgroundFrame"):WaitForChild("ForegroundFrame"):WaitForChild("Minigame2").Text = "" ..randomminigame2.. ""
	game.StarterGui:WaitForChild("MinigameVoteGUI"):WaitForChild("BackgroundFrame"):WaitForChild("ForegroundFrame"):WaitForChild("Minigame3").Text = "" ..randomminigame3.. ""
	for i,v in pairs(game.Players:GetPlayers()) do
		v.PlayerGui:WaitForChild("MinigameVoteGUI"):WaitForChild("BackgroundFrame"):WaitForChild("ForegroundFrame"):WaitForChild("Minigame1").Text = "" ..randomminigame1.. ""
		v.PlayerGui:WaitForChild("MinigameVoteGUI"):WaitForChild("BackgroundFrame"):WaitForChild("ForegroundFrame"):WaitForChild("Minigame2").Text = "" ..randomminigame2.. ""
		v.PlayerGui:WaitForChild("MinigameVoteGUI"):WaitForChild("BackgroundFrame"):WaitForChild("ForegroundFrame"):WaitForChild("Minigame3").Text = "" ..randomminigame3.. ""
	end
	phase = "Voting"
	m = Instance.new("Message", game.Workspace)
	m.Text = "The voting session has begun!"
	wait(4)
	m:Destroy()
	h = Instance.new("Hint", game.Workspace)
	for i = votingsessiontime, 1, -1 do
		h.Text = "There are " ..i.. " seconds left in the voting session! Look to the left of your screen to vote for a minigame!"
		wait(1)
	end
	for i,v in pairs(game.Workspace:GetChildren()) do
		if string.sub(v.Name, 1, 5) == "Votes" then
			if v.Value > mostvotes then
				for n = 1, #winninggames do
					table.remove(winninggames, n)
				end
				table.insert(winninggames, string.sub(v.Name, 6))
				mostvotes = v.Value
			elseif v.Value == mostvotes then
				table.insert(winninggames, string.sub(v.Name, 6))
			end
		end
	end
	game.StarterGui.MinigameVoteGUI:Destroy()
	for i,v in pairs(game.Players:GetPlayers()) do
		if v.PlayerGui:findFirstChild("MinigameVoteGUI") then
			v.PlayerGui.MinigameVoteGUI:Destroy()
		end
	end
	h:Destroy()
	m = Instance.new("Message", game.Workspace)
	m.Text = "The voting session has ended!"
	wait(4)
	if #winninggames == 1 then
		m.Text = "The minigame chosen is [" ..string.upper(winninggames[1]).. "]!"
	elseif winninggames ~= 1 then
		randomwinninggame = winninggames[math.random(1, #winninggames)]
		for i = 1, #winninggames do
			if winninggames[i] ~= randomwinninggame then
				table.remove(winninggames, i)
			end
		end
		m.Text = "There was a tie between two or three minigames! A random minigame that won has been selected! The minigame is [" ..string.upper(winninggames[1]).. "]!"
	end
	wait(4)
	m:Destroy()
	for i,v in pairs(game.Players:GetPlayers()) do
		if v.Participating.Value == true then
			if v.Backpack:findFirstChild("Customize") then
				v.Backpack.Customize:Destroy()
			end
			if v.Character:findFirstChild("Customize") then
				v.Character.Customize:Destroy()
			end
			if v.PlayerGui:findFirstChild("CustomizeGUI") then
				v.PlayerGui.CustomizeGUI:Destroy()
			end
			if v.Backpack:findFirstChild("Balloon") then
				v.Backpack.Balloon:Destroy()
			end
			if v.Character:findFirstChild("Balloon") then
				v.Character.Balloon:Destroy()
			end
		end
	end
	for i,v in pairs(game.Workspace:GetChildren()) do
		if string.sub(v.Name, 1, 14) == "Customization_" then
			playerName = string.sub(v.Name, 15)
			if game.Players["" ..playerName.. ""].Participating.Value == true then
				for n,m in pairs(v:GetChildren()) do
					m:Destroy()
				end
			end
		end
	end
	clonedgame = minigamemodels["" ..winninggames[1].. ""]:Clone()
	clonedgame.Parent = game.Workspace
	clonedgame.GameScript.Disabled = false
	repeat wait() until clonedgame.GameScript.Disabled == true
	numberwinnersfound = 0
	for i,v in pairs(clonedgame:GetChildren()) do
		if string.sub(v.Name, 1, 6) == "Winner" then
			table.insert(minigamewinners, v.Value)
			numberwinnersfound = numberwinnersfound + 1
		end
	end
	m = Instance.new("Message", game.Workspace)
	if numberwinnersfound == 1 then
		m.Text = "" ..clonedgame.Winner1.Value.. " has won the minigame! They have been awarded 100,000 cash, 1 strength, and 100 player points!"
		game.Players["" ..clonedgame.Winner1.Value.. ""].leaderstats.Cash.Value = game.Players["" ..clonedgame.Winner1.Value.. ""].leaderstats.Cash.Value + 100000
		game.Players["" ..clonedgame.Winner1.Value.. ""].leaderstats.Strength.Value = game.Players["" ..clonedgame.Winner1.Value.. ""].leaderstats.Strength.Value + 1
		game:GetService("PointsService"):AwardPoints(game.Players["" ..clonedgame.Winner1.Value.. ""].userId, 100)
		wait(4)
		m:Destroy()
	elseif numberwinnersfound > 1 then
		m.Text = "Two or more people have tied for first place in the minigame!"
		wait(3)
		m.Text = "The 100,000 dollar cash prize has been split evenly among them! Each of them will receive 1 strength and 100 player points!"
		for i,v in pairs(game.Players:GetPlayers()) do
			for n,m in pairs(minigamewinners) do
				if v.Name == m then
					v.leaderstats.Cash.Value = v.leaderstats.Cash.Value + math.floor(100000/numberwinnersfound)
					v.leaderstats.Strength.Value = v.leaderstats.Strength.Value + 1
					game:GetService("PointsService"):AwardPoints(v.userId, 100)
				end
			end
		end
		wait(3)
		m.Text = "The tied winners are:"
		wait(3)
		for i = 1, numberwinnersfound do
			m.Text = "" ..minigamewinners[i].. ""
			wait(2)
		end
		m.Text = "Each of them has received " ..math.floor(100000/numberwinnersfound).. " cash, 1 strength, and 100 player points!"
		wait(3)
		m:Destroy()
	end
	clonedgame:Destroy()
	chosenminigames = {}
	currentminigame = nil
	winninggames = {}
	minigamewinners = {}
	phase = nil
	maxplayers = 2
	mostvotes = 0
	for i,v in pairs(game.Players:GetPlayers()) do
		v:WaitForChild("CurrentVote").Value = ""
		v:WaitForChild("Participating").Value = false
	end
	numbervaluecheck = 1
	for i,v in pairs(game.Workspace:GetChildren()) do
		if v:IsA("IntValue") then
			v.Name = "VotesMinigame" ..numbervaluecheck.. ""
			v.Value = 0
			numbervaluecheck = numbervaluecheck + 1
		end
	end
	h = Instance.new("Hint", game.Workspace)
	for i = 30, 1, -1 do
		h.Text = "Intermission... " ..i.. " seconds left..."
		wait(1)
	end
	h:Destroy()
end