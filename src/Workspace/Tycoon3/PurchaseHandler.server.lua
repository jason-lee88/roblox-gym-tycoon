objects = {}
config = game.ServerScriptService.CoreScript.Configuration
wait(1)

script.Parent:WaitForChild("Buttons")
for i,v in pairs(script.Parent.Buttons:GetChildren()) do
	if v:FindFirstChild("Head") then
		
		local object = script.Parent.Purchases:FindFirstChild(v.Object.Value)
		if object ~= nil then
			objects[object.Name] = object:Clone()
			object:Destroy()
		else
			print("Button: "..v.Name.." is missing its object and has been removed.")
			v.Head.CanCollide = false
			v.Head.Transparency = 1
		end
								
		if v:FindFirstChild("Dependency") then
			v.Head.CanCollide = false
			v.Head.Transparency = 1
			coroutine.resume(coroutine.create(function()
				if script.Parent.PurchasedObjects:WaitForChild(v.Dependency.Value) then
					if config.ButtonFadeInDependency.Value == true then
						for i=1,20 do
							wait(config.ButtonFadeInTime.Value/20)
							v.Head.Transparency = v.Head.Transparency - 0.05
						end
					end
					v.Head.CanCollide = true
					v.Head.Transparency = 0
				end
			end))
		end
		
		v.Head.Touched:connect(function(hit)
			local player = game.Players:GetPlayerFromCharacter(hit.Parent)
			if v.Head.CanCollide == true then
				if player ~= nil then
					if script.Parent.Owner.Value == player then
						if hit.Parent:FindFirstChild("Humanoid") then
							if hit.Parent.Humanoid.Health > 0 then
								if player.leaderstats.Cash.Value >= v.Price.Value then
									player.leaderstats.Cash.Value = player.leaderstats.Cash.Value - v.Price.Value
									objects[v.Object.Value].Parent = script.Parent.PurchasedObjects
									if config.ButtonExplodeOnBuy.Value == true then
										local explosion = Instance.new("Explosion",workspace)
										explosion.Position = v.Head.Position
										explosion.DestroyJointRadiusPercent = 0
										explosion.BlastPressure = 0
									end
									if config.ButtonFadeOutOnBuy.Value == true then
										v.Head.CanCollide = false
										coroutine.resume(coroutine.create(function()
											for i=1,20 do
												wait(config.ButtonFadeOutTime.Value/20)
												v.Head.Transparency = v.Head.Transparency + 0.05
											end
										end))
									else
										v.Head.CanCollide = false
										v.Head.Transparency = 1
									end
								end
							end
						end
					end
				end
			end
		end)
	end
end