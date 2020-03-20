running = script.Parent.Parent.Parent.Parent.Running
speed = script.Parent.Parent.Parent.Parent.Speed
maxspeed = script.Parent.Parent.Parent.Parent.MaxSpeed

script.Parent.MouseButton1Click:connect(function()
	if running.Value == true then
		speed.Value = 0
		script.Parent.Parent.Parent.SpeedDisplay.Text = "OFF"
		running.Value = false
	end
end)