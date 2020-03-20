t1 = script.Parent.Text1
t2 = script.Parent.Text2
t3 = script.Parent.Text3
t4 = script.Parent.Text4
t5 = script.Parent.Text5
t6 = script.Parent.Text6
t7 = script.Parent.Text7
t8 = script.Parent.Text8
t9 = script.Parent.Text9
t10 = script.Parent.Text10

function added(child)
	if child.Name == "SpamCheck_" ..script.Parent.Parent.Parent.Parent.Name.. "" 
	or child.Name == "ChatLog" then
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
		t10.TextColor3 = child.Color.Value
		t10.Text = child.Value
	end
end

game.ServerScriptService.ChatRecorder.ChildAdded:connect(added)