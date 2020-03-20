dp = script.Parent.Parent.DisplayPart

dp.Running.Changed:connect(function(newValue)
	if newValue == false then
		script.Parent.Velocity = script.Parent.CFrame.lookVector * 0
	elseif newValue == true then
		script.Parent.Velocity = script.Parent.CFrame.lookVector * dp.Speed.Value
	end
end)

dp.Speed.Changed:connect(function(newValue)
	if newValue > 0 then
		script.Parent.Velocity = script.Parent.CFrame.lookVector * dp.Speed.Value
	end
end)