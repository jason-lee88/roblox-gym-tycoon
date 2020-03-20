chatLimit = 5
timeBeforeReset = 7
chatBucket = {}

groupid = 0
gamepassid = 188126876

game.Players.PlayerAdded:connect(function(player)
	local cc = Instance.new("Color3Value", player)
	cc.Name = "ChatColor"
	local gc = Instance.new("StringValue", player)
	gc.Name = "GroupCheck"
	local sc = Instance.new("StringValue", player)
	sc.Name = "StrengthCheck"
	local fc = Instance.new("BoolValue", player)
	fc.Name = "FloodCheck"
	if game:GetService("GamePassService"):PlayerHasPass(player, 188126876) then
		cc.Value = Color3.new(255/255, 215/255, 0/255)
	else cc.Value = Color3.new(255/255, 255/255, 255/255)
	end
	if player:IsInGroup(groupid) then
		gc.Value = "[" ..player:GetRoleInGroup(groupid).. "] "
	end
	local pages = game:GetService("DataStoreService"):GetOrderedDataStore("Strength"):GetSortedAsync(false, 100)
	local data = pages:GetCurrentPage()
	for i,v in pairs(data) do
		if player.Name == v.key then
			local place = i
			sc.Value = "[#" ..place.. " Top Strength] "
		end
	end
	player.Chatted:connect(function(msg)
		table.insert(chatBucket, player.Name)
		local chat = Instance.new("StringValue")
		chat.Name = "ChatLog"
		chat.Value = "" ..sc.Value.. "" ..gc.Value.. "" ..player.Name.. ": " ..msg.. ""
		local color = Instance.new("Color3Value", chat)
		color.Name = "Color"
		color.Value = cc.Value
		local gui = game.StarterGui.ChatService.Chats
		local t1 = gui.Text1
		local t2 = gui.Text2
		local t3 = gui.Text3
		local t4 = gui.Text4
		local t5 = gui.Text5
		local t6 = gui.Text6
		local t7 = gui.Text7
		local t8 = gui.Text8
		local t9 = gui.Text9
		local t10 = gui.Text10
		t1.TextColor3 = t2.TextColor3
		t1.Text = t2.Text
		t2.TextColor3 = t3.TextColor3
		t2.Text = t3.Text
		t3.TextColor3 = t4.TextColor3
		t3.Text = t4.Text
		t4.TextColor3 = t5.TextColor3
		t4.Text = t5.Text
		t5.TextColor3 = t6.TextColor3
		t5.Text = t6.Text
		t6.TextColor3 = t7.TextColor3
		t6.Text = t7.Text
		t7.TextColor3 = t8.TextColor3
		t7.Text = t8.Text
		t8.TextColor3 = t9.TextColor3
		t8.Text = t9.Text
		t9.TextColor3 = t10.TextColor3
		t9.Text = t10.Text
		t10.TextColor3 = color.Value
		t10.Text = chat.Value
		chat.Parent = script
		game:GetService("Debris"):AddItem(chat, 3)
		local chattedTimes = 0
		for i,v in pairs(chatBucket) do
			if player.Name == v then
				chattedTimes = chattedTimes + 1
			end
		end
		if chattedTimes >= chatLimit and fc.Value == false then
			for i,v in pairs(chatBucket) do
				if player.Name == v then
					table.remove(chatBucket, i)
				end
			end
			local chat = Instance.new("StringValue")
			chat.Name = "SpamCheck_" ..player.Name.. ""
			chat.Value = "[CONSOLE]: WARNING - Stop spamming or you will be kicked. Thank you."
			local color = Instance.new("Color3Value", chat)
			color.Name = "Color"
			color.Value = Color3.new(1,0,1)
			chat.Parent = script
			game:GetService("Debris"):AddItem(chat, 3)
			fc.Value = true
		elseif chattedTimes >= chatLimit and fc.Value == true then
			player:Kick()
			local chat = Instance.new("StringValue")
			chat.Name = "ChatLog"
			chat.Value = "[CONSOLE]: " ..player.Name.. " has been kicked for spamming the chat."
			local color = Instance.new("Color3Value", chat)
			color.Name = "Color"
			color.Value = Color3.new(1,0,1)
			local gui = game.StarterGui.ChatService.Chats
			local t1 = gui.Text1
			local t2 = gui.Text2
			local t3 = gui.Text3
			local t4 = gui.Text4
			local t5 = gui.Text5
			local t6 = gui.Text6
			local t7 = gui.Text7
			local t8 = gui.Text8
			local t9 = gui.Text9
			local t10 = gui.Text10
			t1.TextColor3 = t2.TextColor3
			t1.Text = t2.Text
			t2.TextColor3 = t3.TextColor3
			t2.Text = t3.Text
			t3.TextColor3 = t4.TextColor3
			t3.Text = t4.Text
			t4.TextColor3 = t5.TextColor3
			t4.Text = t5.Text
			t5.TextColor3 = t6.TextColor3
			t5.Text = t6.Text
			t6.TextColor3 = t7.TextColor3
			t6.Text = t7.Text
			t7.TextColor3 = t8.TextColor3
			t7.Text = t8.Text
			t8.TextColor3 = t9.TextColor3
			t8.Text = t9.Text
			t9.TextColor3 = t10.TextColor3
			t9.Text = t10.Text
			t10.TextColor3 = color.Value
			t10.Text = chat.Value
			chat.Parent = script
			game:GetService("Debris"):AddItem(chat, 3)
		end
	end)
end)

while true do
	wait(timeBeforeReset)
	chatBucket = {}
end