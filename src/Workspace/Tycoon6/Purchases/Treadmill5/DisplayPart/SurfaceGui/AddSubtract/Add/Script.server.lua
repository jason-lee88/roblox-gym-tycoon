running = script.Parent.Parent.Parent.Parent.Running
speed = script.Parent.Parent.Parent.Parent.Speed
maxspeed = script.Parent.Parent.Parent.Parent.MaxSpeed

script.Parent.MouseButton1Click:connect(function()
	if running.Value == true and speed.Value < maxspeed.Value then
		speed.Value = speed.Value + 1
		script.Parent.Parent.Parent.SpeedDisplay.Text = "Speed: " ..speed.Value.. ""
	end
end)